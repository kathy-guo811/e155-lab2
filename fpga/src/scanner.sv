// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Scanner that that has four outputs that rotate between exerting 1000, 0100, 0010, and 0001 
// such that each bit toggles at a rate of 2 Hz


module scanner #(
	parameter width = 23,
	parameter max_count = 24'd10000000)
   (input logic clk,
	input logic reset,
	input logic enable,
	output logic [3:0] row
);

	logic [width:0] count;

	always_ff @(posedge clk) begin
		if (reset == 0)
			count <= 0;
            row <= 4'b1000;
		else if (enable)
			if (count == max_count)
				count <= 0;
                if (row == 4'b0001)
                    row <= 4'b1000;
                else
                    row <= row >> 1;
			else
				count <= count + 1;
		else
			count <= count;
	end

endmodule