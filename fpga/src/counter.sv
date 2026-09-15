// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Counter that increments on each positive clock edge. 
// Once it reaches max_count, counter it resets to zero and it switches 


module counter #(
	parameter width = 23,
	parameter max_count = 24'd250000)
   (input logic clk,
	input logic reset,
	input logic enable,
	output logic digit_select
);

	logic [width:0] count;

	always_ff @(posedge clk) begin
		if (reset == 0) begin
			count <= 0;
            digit_select <= 0;
		end
		else if (enable) begin
			if (count == max_count) begin
				count <= 0;
                digit_select <= ~digit_select;
			end
			else begin
				count <= count + 1;
			end
		else
			count <= count;
		end
	end

endmodule