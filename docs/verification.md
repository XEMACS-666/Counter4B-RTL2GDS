# Verification

## RTL simulation

Run `make sim`. The testbench uses an explicit 1 ns / 1 ps timescale, opens waveform recording before stimulus, and checks outputs after nonblocking assignments settle.

It checks 44 rising edges, including initial reset, counting through wraparound, a reset asserted between rising edges, a second reset interval, and resumed counting. It exits with an error on mismatch and writes a VCD to `build/sim/`.

## Mapped-netlist check

Run `make verify`. The Python script parses the selected synthesis netlist, alternate synthesis netlist, and routed netlist and checks all 32 combinations for each netlist of a four-bit state and binary reset against the expected next-state equation. It also checks that four DFFQX1 cells use `clk` and drive the four output bits.

The checker assumes conventional Boolean meanings for the listed gates and a positive-edge DFFQX1. Its expected behavior is manually derived from the RTL. It does not dynamically parse RTL semantics, model X/Z values, model delays, use foundry cells, or establish physical equivalence. Revisit the expected behavior if the RTL changes. Do not run Python with `-O`, which disables its assertions.

Fresh output is written to `build/verification/logic_results.json`; the checked-in text and JSON in `results/verification/` record the preparation run. Simulation evidence is in `results/verification/simulation_results.txt`.

The Genus synthesis flow was not rerun. Original reports are preserved evidence, separate from the checks performed here.

## Physical-artifact consistency

Run `make structure`. The original structural checker, adapted to `history/counter_proj`, compares the synthesized/routed netlist instances and pins, DEF cell types and signal endpoints, and GDS standard-cell reference counts. The result is recorded in [structure_results.txt](../results/verification/structure_results.txt). This is not extracted layout connectivity, LVS, geometry equivalence, or a fresh DRC run.

## Visual evidence

Run `make visuals` to rerun simulation and regenerate the circuit, netlist, waveform, and synthesis-result SVGs using Python's standard library. The waveform uses real VCD value changes; the results graphic parses original reports. The RTL circuit is a functional illustration, and the mapped circuit uses actual instance/pin labels. Original PNG screenshots are preserved separately without modification.
