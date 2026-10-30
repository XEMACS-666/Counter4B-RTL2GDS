"""Exhaustive two-state next-state check using conventional gate functions.
Not a foundry-model simulation; does not test timing, X/Z, or physical layout.
The expected next-state equation was manually derived from the recovered RTL.
This script parses netlists, not arbitrary RTL; revisit its expectation if RTL changes.
"""
import re,json,sys
from pathlib import Path
root=Path(__file__).resolve().parents[2]
netlist=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else root/'results/netlist/counter_netlist.v'
models={
 'AND2X1':lambda p:p['A'] & p['B'],
 'NAND2XL':lambda p:1-(p['A'] & p['B']),
 'NOR2XL':lambda p:1-(p['A'] | p['B']),
 'NOR3X1':lambda p:1-(p['A'] | p['B'] | p['C']),
 'AOI21XL':lambda p:1-((p['A0'] & p['A1']) | p['B0']),
 'OAI21XL':lambda p:1-((p['A0'] | p['A1']) & p['B0']),
}
def parse(path):
 s=path.read_text();s=re.sub(r'/\*.*?\*/','',s,flags=re.S);s=re.sub(r'//[^\n]*','',s)
 inside=s[s.index(';')+1:s.rindex('endmodule')]
 inst=[]
 for statement in inside.split(';'):
  statement=statement.strip()
  if not statement:continue
  if re.match(r'^(input|output|wire)\b',statement):continue
  m=re.fullmatch(r'(\w+)\s+(\\[^\s]+|\w+)\s*\((.*)\)',statement,re.S)
  assert m,repr(statement)
  typ,name,ports=m.groups();pairs=re.findall(r'\.(\w+)\s*\(\s*([^()]+?)\s*\)',ports)
  assert not re.sub(r'\.(\w+)\s*\(\s*([^()]+?)\s*\)','',ports).replace(',','').strip()
  pins=dict(pairs);assert len(pins)==len(pairs)
  inst.append((typ,name,pins))
 return inst
results=[]
for filename in ([netlist] if len(sys.argv)>1 else [netlist, root/'history/counter_proj/syn/netlist.v', root/'history/counter_proj/pnr/counter_routed.v']):
 inst=parse(root/filename);ff=[x for x in inst if x[0]=='DFFQX1'];gates=[x for x in inst if x[0]!='DFFQX1']
 assert len(ff)==4 and len(gates)==10
 assert {p['Q'] for _,_,p in ff}=={f'count[{i}]' for i in range(4)}
 assert all(p['CK']=='clk' and set(p)=={'CK','D','Q'} for _,_,p in ff)
 for typ,_,pins in gates:assert typ in models and 'Y' in pins
 rows=[]
 for state in range(16):
  for rst in [0,1]:
   nets={'rst':rst,'clk':0,**{f'count[{i}]':(state>>i)&1 for i in range(4)}}
   pending=gates[:]
   while pending:
    ready=[x for x in pending if all(net in nets for pin,net in x[2].items() if pin!='Y')]
    assert ready,'cycle or missing driver'
    for typ,name,pins in ready:
     assert pins['Y'] not in nets,'multiple drivers'
     nets[pins['Y']]=models[typ]({pin:nets[net] for pin,net in pins.items() if pin!='Y'});pending.remove((typ,name,pins))
   nxt=sum(nets[p['D']]<<int(re.fullmatch(r'count\[(\d)\]',p['Q'])[1]) for _,_,p in ff)
   expected=0 if rst else (state+1)%16
   rows.append({'state':state,'rst':rst,'netlist_next':nxt,'rtl_expected':expected,'match':nxt==expected})
 assert all(x['match'] for x in rows)
 results.append({'file':str(filename.relative_to(root)) if filename.is_relative_to(root) else filename.name,'flipflops':len(ff),'gates':len(gates),'passing_cases':len(rows),'rows':rows})
 print(filename.name,': PASS, 32/32 transitions; 4 DFFs on clk + 10 combinational gates')
out=root/'build/verification'
out.mkdir(parents=True,exist_ok=True)
(out/'logic_results.json').write_text(json.dumps(results,indent=2)+'\n')
print('Assumptions: standard Boolean gate meanings and positive-edge DFFQX1; no foundry models available.')
