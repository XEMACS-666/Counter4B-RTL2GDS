# Original run history

This folder preserves the original simulation, synthesis, and implementation evidence, including failed runs. Files retain their original names and contents. Numeric log suffixes distinguish saved files; they are not a reliable chronology by themselves. See [failures and progress](../docs/failures-and-progress.md) for selected evidence.

- `counter_proj/rtl/`: original RTL and the original, uncorrected testbench.
- `counter_proj/sim/`: Xcelium run log, command history, error diagnostics, and text backtrace.
- `counter_proj/syn/`: all original synthesis scripts, command histories, reports, netlists, constraints, and formal-mapping artifacts.
- `counter_proj/pnr/`: all original Innovus run logs and command histories, implementation script, DRC report, routed Verilog, DEF, GDS, stream map, and the unusable `_IMING~1.GZ` payload.
- `counter_proj/gds/`: original convenience copy of the GDS export.
- `earlier-export-141216/`: earlier Verilog, DEF, and GDS exports, kept separate from the later files.

Run `shasum -a 256 -c history/SHA256SUMS` from the repository root to check preserved files and screenshots.

Compiled Xcelium caches and the binary process dump are omitted; readable crash diagnostics are retained. Supporting third-party tutorial videos and asynchronous-counter reference PDFs remain in the original local archive. They are not counter-run evidence. No source files in the local archive were changed.

## Excluded generated payloads

- `.DS_Store`
- `sim/xcelium.d/pakvst.ts`
- `sim/xcelium.d/.history.lock`
- `sim/xcelium.d/history`
- `sim/xcelium.d/worklib/pakvst.ts`
- `sim/xcelium.d/worklib/xm.lnx8664.175.pak`
- `sim/xcelium.d/worklib/.xm.db.175.lnx8664`
- `sim/xcelium.d/worklib/cdsinfo.tag`
- `sim/xcelium.d/worklib/.cdsvmod`
- `sim/xcelium.d/run.lnx8664.22.09.d/.xmlibpath`
- `sim/xcelium.d/run.lnx8664.22.09.d/OVMHOME`
- `sim/xcelium.d/run.lnx8664.22.09.d/.xmrun.lock`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmelab.args`
- `sim/xcelium.d/run.lnx8664.22.09.d/.xmlib.lock`
- `sim/xcelium.d/run.lnx8664.22.09.d/UVMHOME`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmsim.env`
- `sim/xcelium.d/run.lnx8664.22.09.d/tcevlsi.tce.edu_13737_hdlrun.var`
- `sim/xcelium.d/run.lnx8664.22.09.d/hdl.var`
- `sim/xcelium.d/run.lnx8664.22.09.d/tcevlsi.tce.edu_13737_cdsrun.lib`
- `sim/xcelium.d/run.lnx8664.22.09.d/.ncv.lock`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmsim.args`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmsim_restart.env`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmvlog.files`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmvlog.env`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmelab.env`
- `sim/xcelium.d/run.lnx8664.22.09.d/xrun.args`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmelab.hrd`
- `sim/xcelium.d/run.lnx8664.22.09.d/.timestamp.ts`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmvlog.args`
- `sim/xcelium.d/run.lnx8664.22.09.d/cds.lib`
- `sim/xcelium.d/run.lnx8664.22.09.d/xmsim_restart.args`
- `sim/xcelium.d/run.lnx8664.22.09.d/files.ts`
- `sim/xcelium.d/run.lnx8664.22.09.d/hdlrun.var`
- `sim/xcelium.d/run.lnx8664.22.09.d/bind.lst.lnx8664`
- `sim/xcelium.d/run.lnx8664.22.09.d/cdsrun.lib`
- `sim/.bpad/13737_1789630563/dbb68cc4-5557-48e7-a73e86a3-06555dab.dmp`
