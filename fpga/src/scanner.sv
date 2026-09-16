// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Scanner that has four outputs that rotate between exerting 1000, 0100,
// 0010, and 0001, advancing one step each time blinker's led toggles.

module scanner #(
	parameter width = 23,
	parameter max_count = 24'd10000000)
   (input  logic clk,
	input  logic reset,
	input  logic enable,
	output logic [3:0] row
);

	logic led;

	blinker #(.width(width), .max_count(max_count)) blink_s (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.led(led)
	);
	
	always_ff @(posedge led,negedge reset) begin
		if (reset == 0) begin
			row <= 4'b1000;
		end
		else begin
			if (row == 4'b0001)
				row <= 4'b1000;
			else
				row <= row >> 1'b1;
		end
	end

endmodule