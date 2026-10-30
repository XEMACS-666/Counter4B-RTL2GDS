# Design

`counter` contains one four-bit register updated on the rising edge of `clk`.

| Condition at rising edge | Next count |
| --- | --- |
| `rst = 1` | 0 |
| `rst = 0` | `(count + 1) mod 16` |

Reset has priority over increment. It is synchronous: asserting it alone does not immediately update the output. The register has no initialization in the synthesizable RTL; simulation may show an unknown value until a rising edge samples asserted reset.

Truncating the increment result to four bits implements wraparound. All four state bits share the same clock. This is a synchronous counter, even though some reference documents in the source archive discuss asynchronous counters.

The preserved mapped netlist contains four DFFQX1 instances and ten combinational cells: five NOR2XL, one NOR3X1, one NAND2XL, one AND2X1, one AOI21XL, and one OAI21XL.
