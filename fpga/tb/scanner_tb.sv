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

    // instantiate scanner with a very small counter to speed up simulation
    scanner #(
        .width(2),
        .max_count(12)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .row(row)
    );

    // generate clock
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end


    initial begin
        clk = 0;
        reset = 0;
        enable = 0;

        // test 1: reset
        #10;

        assert (row == 4'b1000)
            $display("RESET PASSED");
        else
            $error("RESET FAILED: row = %b", row);


        // test 2: enable and first transition
        reset = 1;
        enable = 1;
        #50;

        assert (row == 4'b0100)
            $display("TRANSITION 1000 -> 0100 PASSED");
        else
            $error("TRANSITION 1000 -> 0100 FAILED: row = %b", row);

        // test 3: second transition
        #40;

        assert (row == 4'b0010)
            $display("TRANSITION 0100 -> 0010 PASSED");
        else
            $error("TRANSITION 0100 -> 0010 FAILED: row = %b", row);


        // test 4: third transition
        #40;

        assert (row == 4'b0001)
            $display("TRANSITION 0010 -> 0001 PASSED");
        else
            $error("TRANSITION 0010 -> 0001 FAILED: row = %b", row);


        // test 5: wrap around
        #40;

        assert (row == 4'b1000)
            $display("TRANSITION 0001 -> 1000 PASSED");
        else
            $error("TRANSITION 0001 -> 1000 FAILED: row = %b", row);


        // test 6: disable
        #40;

        assert (row == 4'b0100)
            $display("SETUP FOR DISABLE PASSED");
        else
            $error("SETUP FOR DISABLE FAILED: row = %b", row);

        // Disable scanner
        enable = 0;

        #80;

        assert (row == 4'b0100)
            $display("DISABLE PASSED");
        else
            $error("DISABLE FAILED: row changed while disabled: row = %b", row);


        // test 7: re-enable
        enable = 1;

        #40;

        assert (row == 4'b0010)
            $display("RE-ENABLE PASSED: 0100 -> 0010");
        else
            $error("RE-ENABLE FAILED: row = %b", row);


        // test 8: reset again when enabled
        reset = 0;

        #10;

        assert (row == 4'b1000)
            $display("RESET WHILE ENABLED PASSED");
        else
            $error("RESET WHILE ENABLED FAILED: row = %b", row);


        // test 9: reset hold
        #40;

        assert (row == 4'b1000)
            $display("RESET HOLD PASSED");
        else
            $error("RESET HOLD FAILED: row = %b", row);


        // test 10: reset release
        reset = 1;

        #40;

        assert (row == 4'b1000)
            $display("RELEASE RESET PASSED: 1000 -> 0100");
        else
            $error("RELEASE RESET FAILED: row = %b", row);


        $display("ALL TESTS COMPLETE");

        $stop;
    end

endmodule