module tb_counter;

    reg clk, rst;
    wire [3:0] count;

    // Instantiate the counter (device under test)
    counter dut (.clk(clk), .rst(rst), .count(count));

    // Clock generator: toggles every 5ns → 100MHz clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #12 rst = 0;        // release reset after 12ns (a bit past 1st edge)
        #200 $finish;       // run for 200ns then stop simulation

        // Dump waveform for viewing in SimVision
        $dumpfile("counter.vcd");
        $dumpvars(0, tb_counter);
    end

    // Print count value every time it changes
    initial $monitor("t=%0t rst=%b count=%d", $time, rst, count);

endmodule
