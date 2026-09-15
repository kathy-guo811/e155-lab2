// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Testbench for scanner module

`timescale 1ns/1ns

module scanner_tb;

    logic clk;
    logic reset;
    logic enable;
    logic [3:0] row;

    // Instantiate scanner with a very small counter
    // so simulation runs quickly.
    scanner #(
        .width(2),
        .max_count(3)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .row(row)
    );

    /// generate clock
	always begin
		clk = 0; #5;
		clk = 1; #5;
	end


    initial begin
        clk = 0;
        reset = 0;
        enable = 0;

        #10;

        // test reset
        assert (row == 4'b1000)
            $display("RESET PASSED");
        else
            $display("RESET FAILED: row = %b", row);

        // Enable scanner
        reset = 1;
        enable = 1;

        // first transition
        #40;

        assert (row == 4'b0100)
            $display("TRANSITION 1000 -> 0100 PASS");
        else
            $error("TRANSITION 1000 -> 0100 FAILED: row = %b", row);

        // second transition
         #40;

        assert (row == 4'b0010)
            $display("TRANSITION 0100 -> 0010 PASS");
        else
            $error("TRANSITION 0100 -> 0010 FAILED: row = %b", row);

        // third transition
        #40;

        assert (row == 4'b0001)
            $display("TRANSITION 0010 -> 0001 PASS");
        else
            $error("TRANSITION 0010 -> 0001 FAILED: row = %b", row);

        // fourth transition
        #40;

        assert (row == 4'b1000)
            $display("TRANSITION 0001 -> 1000 PASS");
        else
            $error("TRANSITION 0001 -> 1000 FAILED: row = %b", row);

        // test enable
        enable = 0;

        #80;

        assert (row == 4'b1000)
            $display("ENABLE PASS");
        else
            $error("ENABLE FAILED: row changed while disabled");

        $stop;
    end

endmodule