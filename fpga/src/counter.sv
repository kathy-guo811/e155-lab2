// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Wraps blinker to produce digit_select, the multiplex toggle for the
// dual seven-segment display.

module counter #(
  parameter width,
  parameter max_count
	)(
	input  logic clk,
	input  logic reset,
	input  logic enable,
	output logic digit_select
	);

	blinker #(.width(width), .max_count(max_count)) blink_c (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.count(digit_select)
	);

endmodule