.PHONY: sim verify synthesis
IVERILOG ?= iverilog
VVP ?= vvp
PYTHON ?= python3
GENUS ?= genus

sim:
	mkdir -p build/sim
	$(IVERILOG) -g2012 -s tb_counter -o build/sim/counter_sim tb/tb_counter.v src/counter.v
	cd build/sim && $(VVP) counter_sim

verify:
	$(PYTHON) scripts/verification/check_logic.py

synthesis:
	mkdir -p build/synthesis
	cd build/synthesis && $(GENUS) -batch -files ../../scripts/synthesis/syn.tcl
