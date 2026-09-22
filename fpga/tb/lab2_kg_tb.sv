// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Testbench for lab 2 top module

`timescale 1ns/1ns

module lab2_kg_tb;

    logic [3:0] sl;
    logic [3:0] sr;
    logic [3:0] col;
    logic rst, enable;

    logic [6:0] segment;
    logic [1:0] anode;
    logic [3:0] led;
    logic [3:0] row;
     
    lab2_kg #() dut (
        .sl(sl),
        .sr(sr),
        .rst(rst),
        .col(col),
        .segment(segment),
        .anode(anode),
        .led(led),
        .row(row)
    );

    initial begin
    
        rst = 0;

        #20;

        // test reset
        assert (row == 4'b1000)
            $display("TOP RESET PASS");
        else
            $error("TOP RESET FAILED: led = %b", led);
        
        // release reset
        rst = 1;

        // test Enable
        enable = 1;

        #20;
        
        assert (row == 4'b0100)
            $display("TOP ENABLE PASS");
        else
            $error("TOP ENABLE FAILED: row = %b", row);

        // test led scanning
        #50;
        assert (row == 4'b0100)
            $display("ROW SCAN 1000 -> 0100 PASS");
        else
            $error("ROW SCAN 1000 -> 0100 FAILED: row = %b", row);

        #50;
        assert (row == 4'b0010)
            $display("ROW SCAN 0100 -> 0010 PASS");
        else
            $error("ROW SCAN 0100 -> 0010 FAILED: row = %b", row);

        #50;
        assert (row == 4'b0001)
            $display("ROW SCAN 0010 -> 0001 PASS");
        else
            $error("ROW SCAN 0010 -> 0001 FAILED: row = %b", row);

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