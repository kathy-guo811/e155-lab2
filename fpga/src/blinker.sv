// Kathy Guo
// kaguo@g.hmc.edu
// 9/6/2026
// Blinker module containing a counter that increments on each positive clock edge and toggles an LED indicating output once it reaches max_count.


module blinker #(
	parameter width = 23,
	parameter max_count = 24'd10000000)
   (input logic clk,
	input logic reset,
	input logic enable,
	output logic led
);

	logic [width:0] counter;

	always_ff @(posedge clk) begin
		if (reset == 0)
			counter <= 0;
		else if (enable)
			if (counter == max_count)
				counter <= 0;
			else
				counter <= counter + 1;
		else
			counter <= counter;
	end

	assign led = counter[width];
endmodule