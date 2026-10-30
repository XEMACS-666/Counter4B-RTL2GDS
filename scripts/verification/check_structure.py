"""Project-specific structural comparison; not a general Verilog/DEF/GDS validator.
GDS comparison checks reference type counts only, not electrical connectivity.
"""
import re,json,struct,collections,sys
from pathlib import Path
P=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else Path(__file__).resolve().parents[2]/'history/counter_proj'
def normalize(s):return s.replace('\\','').strip()
def netlist(p):
 s=re.sub(r'/\*.*?\*/|//[^\n]*','',p.read_text(),flags=re.S);a={}
 for typ,name,ports in re.findall(r'(\w+)\s+(\\?[^\s(]+)\s*\((.*?)\)\s*;',s,re.S):
  if typ=='module':continue
  a[normalize(name)]={'type':typ,'ports':dict(re.findall(r'\.(\w+)\s*\(\s*([^\s)]+)\s*\)',ports))}
 return a
s=netlist(P/'syn/counter_netlist.v');r=netlist(P/'pnr/counter_routed.v');print('NETLISTS equal?',s==r,len(s),'pin connections',sum(len(v['ports']) for v in s.values()))
defs=(P/'pnr/counter.def').read_text();sec=re.search(r'\nCOMPONENTS \d+ ;(.*?)END COMPONENTS',defs,re.S)[1]
comps={normalize(n):(t,int(x),int(y),o) for n,t,x,y,o in re.findall(r'-\s+(\S+)\s+(\S+)\s+\+ PLACED \( (\d+) (\d+) \) (\w+)',sec)}
print('DEF components exact match?',{k:v[0] for k,v in comps.items()}=={k:v['type'] for k,v in r.items()})
ns=re.search(r'\nNETS \d+ ;(.*?)END NETS',defs,re.S)[1];nets={}
for m in re.finditer(r'-\s+(\S+)\s+(.*?);',ns,re.S):
 h=m[2].split('+')[0];nets[normalize(m[1])]=sorted(tuple(normalize(x) for x in pair) for pair in re.findall(r'\(\s+(\S+)\s+(\S+)\s+\)',h))
expected=collections.defaultdict(list)
for n,v in r.items():
 for pin,net in v['ports'].items():expected[net].append((n,pin))
for n in ['clk','rst']+[f'count[{i}]' for i in range(4)]:expected[n].append(('PIN',n))
print('DEF nets exact match?',nets=={k:sorted(v) for k,v in expected.items()},'nets',len(nets))
for n in set(nets)|set(expected):
 if nets.get(n)!=sorted(expected.get(n,[])):print('MISMATCH',n,nets.get(n),expected.get(n))
b=(P/'pnr/counter.gds').read_bytes();i=0;cell=None;el=None;els=[]
while i<len(b):
 length,typ,dt=struct.unpack('>HBB',b[i:i+4]);assert length>=4 and length%2==0 and i+length<=len(b);data=b[i+4:i+length];i+=length
 if typ==6:cell=data.rstrip(b'\0').decode()
 if typ in [8,9,10,11,12]:el={'cell':cell,'kind':typ}
 if el is not None:
  if typ==18:el['sname']=data.rstrip(b'\0').decode()
  if typ==16:el['xy']=struct.unpack('>'+'i'*(len(data)//4),data)
  if typ==26:el['strans']=struct.unpack('>H',data)[0]
  if typ==28:el['angle_hex']=data.hex()
  if typ==44:el.setdefault('properties',[]).append(data.rstrip(b'\0').decode())
  if typ==17:els.append(el);el=None
std=[e for e in els if e.get('sname') in {v['type'] for v in r.values()}];print('GDS standard cell references',len(std),collections.Counter(e['sname'] for e in std));print('Expected',collections.Counter(v['type'] for v in r.values()));print(json.dumps(std,indent=2));
print('DEF comps',json.dumps(comps,indent=2))

assert s==r and len(s)==14, 'Synthesized/routed instance or pin mismatch'
assert {k:v[0] for k,v in comps.items()}=={k:v['type'] for k,v in r.items()}, 'DEF component mismatch'
assert nets=={k:sorted(v) for k,v in expected.items()} and len(nets)==16, 'DEF signal endpoint mismatch'
assert collections.Counter(e['sname'] for e in std)==collections.Counter(v['type'] for v in r.values()), 'GDS reference count mismatch'
print('PASS: netlist connections, DEF signal endpoints, and GDS cell-type counts. Not LVS or geometry equivalence.')
