# Failures, retries, and what the evidence establishes

This project includes unsuccessful runs. Original logs are preserved, including repeated and verbose variants; their suffixes alone do not establish execution order. [Complete run index](run-index.md).

| Stage / attempt | Recorded outcome | Source |
| --- | --- | --- |
| Xcelium compile / elaborate | RTL and testbench compiled; hierarchy built | [xrun.log](../history/counter_proj/sim/xrun.log) |
| Xcelium simulation | `*F,INTERR: INTERNAL EXCEPTION` at `0 FS + 0`; no passing historical simulation | [xrun.log](../history/counter_proj/sim/xrun.log), [crash diagnostics](../history/counter_proj/sim/xmsim_13737.err) |
| Genus synthesis | Saved mapped netlist, exported constraints, timing / area / power reports | [synthesis history](../history/counter_proj/syn), [selected reports](../results/reports) |
| Innovus technology loading | `Metal1` undefined, via creation failed, no technology information, LEF loading aborted | [innovus_run.log](../history/counter_proj/pnr/innovus_run.log) |
| Innovus alternate LEF input | LEF processing error in `all.lef` | [innovus_run.log2](../history/counter_proj/pnr/innovus_run.log2) |
| Innovus constraints command | `invalid command name "read_sdc"`; script stopped | [innovus_run.log3](../history/counter_proj/pnr/innovus_run.log3) |
| Innovus floorplan | `core` did not match a valid site; floorplan command failed | [innovus_run.log4](../history/counter_proj/pnr/innovus_run.log4) |
| Innovus power ring | Required `-layer` argument missing from `addRing` | [innovus_run.log6](../history/counter_proj/pnr/innovus_run.log6) |
| Innovus GUI invocation | Unknown `-gui` argument | [innovus.logv](../history/counter_proj/pnr/innovus.logv) |
| DEF opened as Tcl | `source` failed on `VERSION` | [innovus.log4](../history/counter_proj/pnr/innovus.log4) |
| Later placement / routing | Physical-only initialization, missing timing constraint file, non-timing-driven placement | [innovus.log6](../history/counter_proj/pnr/innovus.log6) |
| Timing-graph construction | `IMPDC-634`: timing libraries had not been loaded | [innovus.log6](../history/counter_proj/pnr/innovus.log6) |
| Historical DRC check | Saved `verify_drc` report says no DRC violations, September 17 at 14:13:17 | [counter.drc.rpt](../history/counter_proj/pnr/counter.drc.rpt) |
| Physical exports | Routed Verilog, DEF, and GDS files exist; later verbose log records export activity at 17:02:28 | [innovus.logv6](../history/counter_proj/pnr/innovus.logv6), [physical files](../history/counter_proj/pnr) |
| New RTL simulation | Corrected testbench passes 44 clock-edge checks | [simulation results](../results/verification/simulation_results.txt) |
| New Boolean checks | Each of three mapped netlists passes all 32 state/reset combinations | [logic results](../results/verification/logic_results.txt) |
| New structural checks | Synthesis/routed cell connections and DEF endpoints match; GDS cell-reference counts match | [structure results](../results/verification/structure_results.txt) |

## What changed during the historical attempts?

The logs move from LEF loading failures to sessions that initialize the design, attempt floorplanning and rings, and ultimately export physical files. This is evidence of progress through the flow, but the archive does not contain a complete version history of every edit to `invs.tcl`. The command histories are retained so readers can inspect the actual commands. We do not invent fixes or claim each error was resolved.

Later exports still coexist with missing timing-library errors. The zero-violation DRC report belongs to its recorded historical run; it is not a fresh sign-off result for all exported files. No LVS or post-route timing closure is established. The saved GDS lacks definitions for referenced standard-cell masters, and the original `_IMING~1.GZ` file is an unusable zero-filled payload. Successful export alone does not establish a complete, manufacturable design.

## What changed in the public testbench?

The original testbench placed waveform setup after `$finish` and omitted an explicit timescale. Both are preserved in [the original testbench](../history/counter_proj/rtl/tb_counter.v). The runnable [testbench](../tb/tb_counter.v) fixes those issues and adds assertions. Its successful Icarus run is new evidence; it does not retroactively resolve or explain the old Xcelium internal exception.
