// Kathy Guo
// kaguo@g.hmc.edu
// 9/6/2026
// Seven-segment display module that displays a single hexadecimal digit specified by s[3:0].


module seven_segment_display (
	input  logic [3:0] sw6, // input from 4 DIP switches SW6
	output logic [6:0] seg); // output from 7-segment display

	always_comb
	case (sw6)
		4'h0: seg = 7'b1000000;
		4'h1: seg = 7'b1001111;
		4'h2: seg = 7'b0100100;
		4'h3: seg = 7'b0110000;
		4'h4: seg = 7'b0011001;
		4'h5: seg = 7'b0010010;
		4'h6: seg = 7'b0000010;
		4'h7: seg = 7'b1111000;
		4'h8: seg = 7'b0000000;
		4'h9: seg = 7'b0011000;
		4'hA: seg = 7'b0001000;
		4'hB: seg = 7'b0000011;
		4'hC: seg = 7'b1000110;
		4'hD: seg = 7'b0100001;
		4'hE: seg = 7'b0000110;
		4'hF: seg = 7'b0001110;
		default: seg = 7'b1111111; //set default output to all segments OFF
	endcase
endmodule