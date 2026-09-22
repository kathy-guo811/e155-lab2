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

	logic led;
	logic led_prev;

	blinker #(.width(width), .max_count(max_count/4)) blink_s (
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.led(led)
	);

	always_ff @(posedge clk, negedge reset) begin
		if (reset == 0) begin
			state    <= 2'd0;
			led_prev <= 1'b0;
		end
		else begin
			led_prev <= led;
			if (led != led_prev) begin
				if (state == 2'd3)
					state <= 2'd0;
				else
					state <= state + 2'd1;
			end
		end
	end

	assign row[3] = (state == 2'd0);
	assign row[2] = (state == 2'd1);
	assign row[1] = (state == 2'd2);
	assign row[0] = (state == 2'd3);

endmodule