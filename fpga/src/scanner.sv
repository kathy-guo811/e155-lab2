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

	logic led, led_prev;

	blinker #(.width(width), .max_count(max_count)) blink_s (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.led(led)
	);

	always_ff @(posedge clk) begin
		if (reset == 0) begin
			row <= 4'b1000;
			led_prev <= 0;
		end
		else begin
			led_prev <= led;
			if (led != led_prev) begin        // edge detected
				if (row == 4'b0001)
					row <= 4'b1000;
				else
					row <= row >> 1'b1;
			end
		end
	end

endmodule