# 1. Setup Library
set_db library /home/install/FOUNDRY/digital/90nm/dig/lib/typical.lib

# 2. Read RTL
# Assuming your counter is in ../rtl/counter.v and the module is named "counter"
read_hdl ../rtl/counter.v

# 3. Elaborate Design
elaborate

# 4. Apply Constraints (100 MHz clock)
# Replace "clk" with the exact name of your clock input port if it differs
create_clock -name clk -period 10 [get_ports clk]

# 5. Synthesize
syn_generic
syn_map
syn_opt

# 6. Generate Reports
report_timing > timing.rpt
report_area > area.rpt
report_power > power.rpt

# 7. Export Outputs for Innovus (Physical Design)
write_hdl > counter_netlist.v
write_sdc > counter_constraints.sdc
