# Verification

## RTL simulation

Run `make sim`. The testbench uses an explicit 1 ns / 1 ps timescale, opens waveform recording before stimulus, and checks outputs after nonblocking assignments settle.

It checks 44 rising edges, including initial reset, counting through wraparound, a reset asserted between rising edges, a second reset interval, and resumed counting. It exits with an error on mismatch and writes a VCD to `build/sim/`.

## Mapped-netlist check

Run `make verify`. The Python script parses the saved mapped netlist and checks all 32 combinations of a four-bit state and binary reset against the expected next-state equation. It also checks that four DFFQX1 cells use `clk` and drive the four output bits.

The checker assumes conventional Boolean meanings for the listed gates and a positive-edge DFFQX1. Its expected behavior is manually derived from the RTL. It does not dynamically parse RTL semantics, model X/Z values, model delays, use foundry cells, or establish physical equivalence. Revisit the expected behavior if the RTL changes. Do not run Python with `-O`, which disables its assertions.

Fresh output is written to `build/verification/logic_results.json`; the checked-in text and JSON in `results/verification/` record the preparation run. Simulation evidence is in `results/verification/simulation_results.txt`.

The Genus synthesis flow was not rerun. Original reports are preserved evidence, separate from the checks performed here.
