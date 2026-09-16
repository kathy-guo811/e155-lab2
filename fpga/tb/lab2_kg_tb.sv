// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Automatic testbench for the top module
// Exercises multiplexing functionality and LED driving functionality.

`timescale 1ns/1ns

module lab2_kg_tb;

    logic [3:0] sl;
    logic [3:0] sr;
    logic rst;

    logic [6:0] segment;
    logic [1:0] anode;
    logic [3:0] led;

    // Instantiate top module
    lab2_kg dut (
        .sl(sl),
        .sr(sr),
        .rst(rst),
        .segment(segment),
        .anode(anode),
        .led(led)
    );

    initial begin

        // Initialize inputs
        sl  = 4'h0;
        sr  = 4'h0;
        rst = 0;

        // test 1: reset
        #20;

        assert (led == 4'b1000)
            $display("RESET PASS: led = %b", led);
        else
            $error("RESET FAILED: led = %b", led);


        // test 2: led scan

        rst = 1;

        // Wait for first row transition
        #50;

        assert (led == 4'b0100)
            $display("LED SCAN 1000 -> 0100 PASS");
        else
            $error("LED SCAN 1000 -> 0100 FAILED: led = %b", led);

        // second row transition
        #50;

        assert (led == 4'b0010)
            $display("LED SCAN 0100 -> 0010 PASS");
        else
            $error("LED SCAN 0100 -> 0010 FAILED: led = %b", led);

        // third row transition
        #50;

        assert (led == 4'b0001)
            $display("LED SCAN 0010 -> 0001 PASS");
        else
            $error("LED SCAN 0010 -> 0001 FAILED: led = %b", led);

        // wrap around
        #50;

        assert (led == 4'b1000)
            $display("LED SCAN 0001 -> 1000 PASS");
        else
            $error("LED SCAN 0001 -> 1000 FAILED: led = %b", led);


        // test 3: time mux

        // Set left and right values
        sl = 4'h3;
        sr = 4'h5;

        // Wait for left digit
        #20;

        assert (anode == 2'b10)
            $display("MUX LEFT DIGIT PASS: anode = %b", anode);
        else
            $error("MUX LEFT DIGIT FAILED: anode = %b", anode);

        // Check that segment output displays 3
        assert (segment == 7'b0110000)
            $display("MUX LEFT VALUE PASS: segment = %b", segment);
        else
            $error("MUX LEFT VALUE FAILED: segment = %b", segment);


        // Wait for right digit
        #20;

        assert (anode == 2'b01)
            $display("MUX RIGHT DIGIT PASS: anode = %b", anode);
        else
            $error("MUX RIGHT DIGIT FAILED: anode = %b", anode);

        // Check that segment output displays 5
        assert (segment == 7'b0010010)
            $display("MUX RIGHT VALUE PASS: segment = %b", segment);
        else
            $error("MUX RIGHT VALUE FAILED: segment = %b", segment);


        // change time-muxed valued

        sl = 4'h1;
        sr = 4'h9;

        #20;

        $display("ALL TOP MODULE TESTS COMPLETE");

        $stop;

    end

endmodule