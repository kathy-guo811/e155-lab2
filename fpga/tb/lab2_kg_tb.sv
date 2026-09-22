// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Testbench for lab 2 top module

`timescale 1ns/1ns

module lab2_kg_tb;

    logic [3:0] sl;
    logic [3:0] sr;
    logic [3:0] col;
    logic rst;

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
    
        // initialize all inputs
        rst = 0;
        sl = 4'h3;
        sr = 4'h5;
        col = 4'b1111;

        #20;

        // test reset
        assert (row == 4'b1000)
            $display("TOP RESET PASS");
        else
            $error("TOP RESET FAILED: led = %b", led);
        
        // release reset
        rst = 1;

        #100;
        
        // test LED drive

        col = 4'b1110;
        #10
        assert (led == 4'b0001)
            $display("LED DRIVING PASS");
        else
            $error("LED DRIVING FAILED: col = %b, led = %b", col, led);

        // time multiplexing

        #20;
        assert (anode == 2'b01)
            $display("ANODE 0 SELECTION PASS");
        else
            $error("ANODE 0 SELECTION FAILED: anode = %b", anode);
        
        assert (segment == 7'b0110000)
          $display("MUX SL = 3 PASS");
        else
            $error("MUX SL = 3 FAILED: segment = %b", segment);

        #1100000;
        assert (anode !== 2'b10)
            $error("ANODE 1 SELECTION FAILED: anode = %b", anode);
        else
            $display("ANODE 1 SELECTION PASS");

        assert (segment == 7'b0010010)
            $display("MUX SR = 5 PASS");
        else
            $error("MUX SR = 5 FAILED: segment = %b", segment);

        $stop;
    end

endmodule