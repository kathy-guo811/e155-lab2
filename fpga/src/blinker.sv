// Kathy Guo
// kaguo@g.hmc.edu
// 9/6/2026
// Blinker module containing a counter that increments on each positive clock edge and toggles an LED indicating output once it reaches max_count.

module blinker #(
	parameter width = 24,
	parameter max_count = 24'd10000000)
  (input logic clk,
	input logic reset,
	input logic enable,
	output logic led
);

	logic [width-1:0] counter;
	logic toggle;
	
	always_ff @(posedge clk, negedge reset) begin
		if (reset == 0) begin
			counter <= 0;
			toggle <= 0;
		end
		else if (enable) begin
			if (counter == max_count) begin
				counter <= 0;
				toggle <= ~toggle;
			end
			else
				counter <= counter + 1;
		end
	end

	assign led = toggle;
endmodule