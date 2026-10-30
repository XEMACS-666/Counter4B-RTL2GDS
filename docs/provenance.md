# Provenance and preparation changes

The source package contained a recovered project tree, verification scripts, and a workflow handoff. This public copy selects the RTL, mapped synthesis netlist, exported constraints, and timing/area/power reports for a synthesis-focused presentation.

## Preserved byte-for-byte

- `src/counter.v`
- `constraints/counter_constraints.sdc`
- `results/netlist/counter_netlist.v`
- `results/reports/area.rpt`, `timing.rpt`, and `power.rpt`

Their SHA-256 hashes are recorded in [SHA256SUMS](SHA256SUMS). From the repository root, run `shasum -a 256 -c docs/SHA256SUMS`.

## Changes prepared October 30, 2026

- Reorganized selected files into source, testbench, scripts, constraints, results, assets, and docs.
- Fixed the testbench's unreachable waveform setup and unspecified timescale; added automated behavioral checks.
- Adapted the original synthesis script to use `COUNTER_LIB`, repository-relative paths, the saved SDC, and a separate build output directory.
- Adapted the existing mapped-logic checker to the selected netlist and build output directory.
- Added documentation, SVG diagrams, Make targets, and ignore rules.

The input archive was not modified. The original simulation caches, crash dumps, repeated logs, reference videos and PDFs, physical-design files, and recovery bookkeeping remain outside this public copy. Documentation diagrams are explanatory illustrations, not tool screenshots.

Historical synthesis results have not been regenerated in this environment. A license has not been selected by the owner.
