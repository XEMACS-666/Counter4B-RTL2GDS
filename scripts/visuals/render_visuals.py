"""Render documentation SVGs from the saved netlist/reports and fresh simulation VCD.
Standard library only. These are derived illustrations, not Cadence screenshots.
"""
from pathlib import Path
from html import escape
import re
R=Path(__file__).resolve().parents[2]; A=R/'assets';A.mkdir(exist_ok=True)
def text(x,y,s,size=18,color='#dbe8fa',anchor='start'):
 return f'<text x="{x}" y="{y}" font-size="{size}" fill="{color}" text-anchor="{anchor}">{escape(str(s))}</text>'
def line(x,y,x2,y2,color='#68dfc3',width=2):
 return f'<path d="M{x} {y} L{x2} {y2}" stroke="{color}" stroke-width="{width}" fill="none"/>'
def box(x,y,w,h,fill='#20334f'):
 return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="{fill}" stroke="#5e789c"/>'
def save(name,title,w,h,body):
 (A/name).write_text(f'<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}" role="img"><title>{escape(title)}</title><rect width="{w}" height="{h}" fill="#101c30" rx="16"/><g font-family="Arial,Helvetica,sans-serif">'+body+'</g></svg>\n')
# RTL-equivalent circuit: explicit increment logic, reset mask, and shared clock.
b=text(35,44,'RTL-equivalent synchronous counter circuit',27)+text(35,76,'Four rising-edge D flip-flops · reset acts on D, never on an asynchronous reset pin',16,'#9eb4d2')
for i in range(4):
 y=125+i*135
 b+=text(35,y+25,f'Bit {i}',20,'#68dfc3')+text(35,y+55,f'Q{i} = count[{i}]',15)
 inp='1' if i==0 else 'Q0' if i==1 else 'Q1 AND Q0' if i==2 else 'Q2 AND Q1 AND Q0'
 b+=text(190,y+8,inp,16)+line(190,y+18,380,y+18)+text(255,y+64,f'Q{i}',16)+line(290,y+58,380,y+58)
 b+=box(380,y,85,78)+text(422,y+46,'XOR',20,anchor='middle')+line(465,y+38,555,y+38)
 b+=box(555,y,95,78)+text(602,y+46,'AND',20,anchor='middle')+text(500,y-9,'NOT rst',14,'#ffcf80')+line(530,y-4,575,y-4,'#ffcf80')+line(575,y-4,575,y,'#ffcf80')
 b+=line(650,y+38,760,y+38)+text(680,y+26,f'D{i}',16)+box(760,y,110,86)+text(775,y+44,'D',18)+text(845,y+44,'Q',18)+text(815,y+18,'DFF',16,anchor='middle')
 b+=line(870,y+38,1010,y+38)+text(925,y+25,f'Q{i}',18,'#68dfc3')
 b+=f'<path d="M760 {y+60} L772 {y+68} L760 {y+76}" fill="none" stroke="#75b8ff" stroke-width="2"/>'+line(720,y+68,760,y+68,'#75b8ff')
 if i<3:b+=line(720,y+68,720,y+203,'#75b8ff')
b+=text(660,660,'clk',18,'#75b8ff')+line(695,653,720,653,'#75b8ff')+line(720,653,720,598,'#75b8ff')
b+=text(35,710,'Matching Q labels denote feedback connections. Reset high forces every D input to zero.',17)+text(35,743,'Functional schematic derived from src/counter.v; mapped cell implementation is shown separately.',15,'#9eb4d2')
save('counter-circuit.svg','RTL-equivalent four-bit synchronous counter circuit',1100,775,b)
# Exact cell/pin mapping: labels carry actual nets without unreadable crossing wires.
s=(R/'results/netlist/counter_netlist.v').read_text();s=re.sub(r'//[^\n]*','',s)
cells=[]
for typ,name,ports in re.findall(r'(\w+)\s+(\\?[^\s(]+)\s*\((.*?)\)\s*;',s,re.S):
 if typ=='module':continue
 pins=dict(re.findall(r'\.(\w+)\s*\(\s*([^\s)]+)\s*\)',ports));cells.append((typ,name.lstrip('\\'),pins))
cells=sorted(cells,key=lambda c:(c[0]=='DFFQX1',c[1]))
b=text(30,42,'Mapped circuit • all 14 cells and 45 pin connections',27)+text(30,75,'Generated from counter_netlist.v. Identical net labels are electrically connected.',17,'#9eb4d2')
for k,(typ,name,pins) in enumerate(cells):
 # 10 gates in three rows; flops on the fourth.
 col=k%4;row=k//4
 if k>=10:col=k-10;row=3
 x=30+col*375;y=115+row*245
 b+=text(x,y,name,16,'#68dfc3')+box(x+105,y+20,160,155)+text(x+185,y+48,typ,18,anchor='middle')
 out='Q' if typ=='DFFQX1' else 'Y';inputs=[(pin,net) for pin,net in pins.items() if pin!=out]
 for j,(pin,net) in enumerate(inputs):
  yy=y+77+j*34;b+=text(x,yy-5,net,16)+line(x+5,yy,x+105,yy)+text(x+112,yy+5,pin,15)
 b+=text(x+250,y+112,out,16,anchor='end')+line(x+265,y+107,x+340,y+107)+text(x+275,y+96,pins[out],16)
b+=text(30,1115,'Cells are shown as pin-labelled symbols; this is a netlist-derived schematic, not a place-and-route view.',17,'#9eb4d2')
save('mapped-circuit.svg','Mapped counter circuit with actual cell instances and named nets',1530,1150,b)
# Read actual VCD value changes. Time units in the generated testbench trace are ps.
vcd=(R/'build/sim/counter.vcd').read_text();assert re.search(r'\$timescale\s+1ps',vcd)
ids={};events={};t=0
for ln in vcd.splitlines():
 m=re.match(r'\$var \w+ \d+ (\S+) (clk|rst|count)\b',ln)
 if m and m[2] not in ids:ids[m[2]]=m[1];events[m[1]]=[]
 if ln.startswith('#'):t=int(ln[1:])/1000
 elif ln.startswith('b'):
  value,code=ln[1:].split()
  if code in events:events[code].append((t,value))
 elif ln and ln[0] in '01xz':
  if ln[1:] in events:events[ln[1:]].append((t,ln[0]))
b=text(30,42,'Simulation waveform • reset, counting, wraparound, reset again',26)+text(30,75,'Actual Icarus Verilog VCD from the corrected testbench · 0–260 ns excerpt',17,'#9eb4d2')
X=lambda t:140+t*4.55
for tm in range(0,261,20):
 b+=line(X(tm),105,X(tm),325,'#2d415f',1)+text(X(tm),355,str(tm),14,'#9eb4d2','middle')
for row,name in enumerate(['clk','rst','count']):
 y=135+row*75;b+=text(25,y+10,name,19,'#68dfc3')
 ev=events[ids[name]]
 for j,(tm,val) in enumerate(ev):
  end=ev[j+1][0] if j+1<len(ev) else 260
  if tm>=260:continue
  end=min(end,260);x1=X(tm);x2=X(end)
  if name=='count':
   b+=box(x1,y-20,max(x2-x1,1),34)+text((x1+x2)/2,y+3,str(int(val,2)) if set(val)<=set('01') else 'X',13,anchor='middle')
  else:
   yy=y-16 if val=='1' else y+14;b+=line(x1,yy,x2,yy)
   if j and ev[j-1][1]!=val:b+=line(x1,y-16,x1,y+14)
b+=text(X(175),397,'15 → 0 at 175 ns',16,'#ffcf80','middle')+text(X(225),430,'rst ↑ at 222 ns; count clears at 225 ns',16,'#ffcf80','middle')+text(30,470,'New simulation evidence; the original Xcelium session crashed at time zero.',16,'#9eb4d2')
save('simulation-waveform.svg','Counter waveform sampled from actual VCD',1390,500,b)
# Report-derived result cards and power breakdown.
area=(R/'results/reports/area.rpt').read_text();tim=(R/'results/reports/timing.rpt').read_text();power=(R/'results/reports/power.rpt').read_text()
a=re.search(r'counter\s+(\d+)\s+([\d.]+)',area);slack=re.search(r'MET \((\d+) ps\)',tim)[1]
power_rows={}
for ln in power.splitlines():
 fields=ln.split()
 if fields and fields[0] in ['register','logic','clock','Subtotal']:power_rows[fields[0]]=float(fields[4])*1e6
b=text(30,42,'Synthesis results • values from the original reports',27)+text(30,75,'Cadence Genus 21.14-s082_1 · September 17, 2026 · typical conditions',17,'#9eb4d2')
for i,(label,val,unit) in enumerate([('MAPPED CELLS',a[1],'4 flip-flops + 10 gates'),('CELL AREA',a[2],'library units; physical unit unverified'),('SETUP SLACK','+'+slack+' ps','displayed path; 10 ns clock'),('TOTAL POWER',f'{power_rows["Subtotal"]:.5f} µW','historical tool estimate')]):
 x=30+i*320;b+=box(x,110,300,150)+text(x+18,140,label,15,'#9eb4d2')+text(x+18,190,val,30,'#68dfc3')+text(x+18,235,unit,13)
b+=text(30,310,'Power by category',22)
x=30;colors=['#68dfc3','#75b8ff','#ffcf80']
for i,name in enumerate(['register','logic','clock']):
 val=power_rows[name];w=1240*val/power_rows['Subtotal'];b+=f'<rect x="{x}" y="335" width="{w}" height="38" fill="{colors[i]}"/>';x+=w
 b+=text(30+i*420,412,f'{name.title()}: {val:.5f} µW',18,colors[i])
b+=text(30,458,'Power activity assumptions are unestablished. These are synthesis estimates, not post-route or silicon measurements.',16,'#9eb4d2')
save('synthesis-results.svg','Synthesis report values and power breakdown',1320,490,b)
print('Generated circuit, mapped netlist, waveform, and synthesis-result SVGs.')
