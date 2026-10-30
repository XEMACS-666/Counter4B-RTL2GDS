`timescale 1ns/1ps
module tb_counter;
    reg clk = 0;
    reg rst = 1;
    wire [3:0] count;
    reg [3:0] expected = 0;
    reg [3:0] held;
    integer checks = 0;
    counter dut (.clk(clk), .rst(rst), .count(count));
    always #5 clk = ~clk;

    // Sample after nonblocking assignments have committed.
    always @(posedge clk) begin
        if (rst) expected = 0;
        else expected = expected + 1'b1;
        #1;
        if (count !== expected)
            $fatal(1, "count=%d expected=%d at %t", count, expected, $time);
        checks = checks + 1;
    end

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_counter);
        repeat (2) @(negedge clk);
        rst = 0;
        repeat (20) @(negedge clk); // Includes 15 -> 0 wraparound.
        held = count;
        #2 rst = 1;                // Assert between rising edges.
        #1;
        if (count !== held)
            $fatal(1, "Reset changed count before rising edge");
        repeat (2) @(negedge clk);
        rst = 0;
        repeat (20) @(negedge clk);
        if (checks != 44) $fatal(1, "Unexpected check count: %d", checks);
        $display("PASS: %0d clock-edge checks; synchronous reset, increment, wraparound", checks);
        $finish;
    end
endmodule
