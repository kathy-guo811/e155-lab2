// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Wraps blinker to produce digit_select, the multiplex toggle for the
// dual seven-segment display.

module counter #(
	parameter width = 23,
	parameter max_count = 17'24000)
   (input  logic clk,
	input  logic reset,
	input  logic enable,
	output logic digit_select
);

	blinker #(.width(width), .max_count(max_count)) blink (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.led(digit_select)
	);

endmodule