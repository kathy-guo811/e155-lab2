// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Scanner that has four outputs that rotate between exerting 1000, 0100,
// 0010, and 0001, advancing one step each time blinker's led toggles.

module scanner #(
	parameter width = 24,
	parameter max_count = 24'd5000000)
	(input  logic clk,
	 input  logic reset,
     input  logic enable,
	 output logic [3:0] row
);

	logic [23:0] count;

	blinker #(.width(width), .max_count(max_count)) blink_s (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.count(count)
	);

	always_comb begin
		if (count <= max_count/4 && count >= 0) row <= 4'b0001;
		else if (count <= max_count/2 && count >= max_count/4) row <= 4'b0010;
		else if (count <= 3*max_count/4 && count >= max_count/2) row <= 4'b0100;
		else row <= 4'b1000;
	end


endmodule