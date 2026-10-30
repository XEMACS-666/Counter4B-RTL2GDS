set init_verilog "../syn/counter_netlist.v"
set init_lef_file "/home/install/FOUNDRY/digital/90nm/dig/lef/gsclib090_translated.lef"
set init_pwr_net "VDD"
set init_gnd_net "VSS"
init_design

floorPlan -r 1.0 0.7 10 10 10 10

globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect VSS -type pgpin -pin VSS -inst *
globalNetConnect VDD -type tiehi -inst *
globalNetConnect VSS -type tielo -inst *
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top M1 bottom M1 left M2 right M2} -width 1 -spacing 0.5
sroute -connect { corePin } -nets {VDD VSS}

placeDesign
routeDesign

saveNetlist counter_routed.v
defOut -routing counter.def
streamOut counter.gds -units 1000 -mode ALL
