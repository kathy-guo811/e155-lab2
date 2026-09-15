// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Testbench for lab 2 top module

`timescale 1ns/1ns

module lab2_kg_tb;

    logic [3:0] sl;
    logic [3:0] sr;
    logic rst;

    logic [6:0] segment;
    logic [1:0] anode;
    logic [3:0] led;

    lab2_kg #() dut (
        .sl(sl),
        .sr(sr),
        .rst(rst),
        .segment(segment),
        .anode(anode),
        .led(led)
    );

    initial begin
    
        rst = 0;

        #20;

        // test reset
        assert (led == 4'b1000)
            $display("TOP RESET PASS");
        else
            $error("TOP RESET FAILED: led = %b", led);

        // release reset
        rst = 1;

        // test led scanning
        #50;
        assert (led == 4'b0100)
            $display("LED SCAN 1000 -> 0100 PASS");
        else
            $error("LED SCAN 1000 -> 0100 FAILED: led = %b", led);

        #50;
        assert (led == 4'b0010)
            $display("LED SCAN 0100 -> 0010 PASS");
        else
            $error("LED SCAN 0100 -> 0010 FAILED: led = %b", led);

        #50;
        assert (led == 4'b0001)
            $display("LED SCAN 0010 -> 0001 PASS");
        else
            $error("LED SCAN 0010 -> 0001 FAILED: led = %b", led);

        // test time mux
        sl = 4'h3;
        sr = 4'h5;

        #20;
        assert (anode == 2'b10)
            $display("ANODE 0 SELECTION PASS");
        else
            $error("ANODE 0 SELECTION FAILED: anode = %b", anode);

        #20;
        assert (anode !== 2'b01)
            $error("ANODE 1 SELECTION FAILED: anode = %b", anode);
        else
            $display("ANODE 1 SELECTION PASS");

        $stop;
    end

endmodule