// Kathy Guo
// kaguo@g.hmc.edu
// 9/14/2026
// Top level module for E155_lab1. 
// Instantiates multiplexing counter module, scanning module and assign statements to implement multiplexing and scanning passthrough.


module lab2_kg(
	input logic [3:0] sl,
    input logic [3:0] sr,
	input logic [3:0] col,
	input logic rst,
	output logic [6:0] segment,
	output logic [1:0] anode,
	output logic [3:0] led,
	output logic [3:0] row
);

	logic int_osc;
	logic digit_select;
	logic [3:0] display_value;
	logic [3:0] scan;
	
	// Internal high-speed oscillator
	HSOSC #(.CLKHF_DIV(2'b01))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

	// Counter for multiplexing
	counter c(
		.clk(int_osc),
		.reset(rst),
		.enable(1'b1),
		.digit_select(digit_select)
	);

	// Select which 4-bit value is sent to the decoder
    assign display_value = digit_select ? sr : sl;

	// 7-segment LED output
	seven_segment_display d(
		.sw6 (display_value),
		.seg (segment)
	);

	// scanner
	scanner s(
        .clk(int_osc),
        .reset(rst),
        .enable(1'b1),
        .row(row)
    );


	// time multiplexing
	assign anode[0] = ~digit_select;
	assign anode[1] = digit_select;
	
	// scanner output
	assign led = ~col;

endmodule
