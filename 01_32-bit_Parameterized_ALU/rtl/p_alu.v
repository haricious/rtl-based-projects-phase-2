`timescale 1ns/1ps

module p_alu #(
	parameter width = 32
)
	(
		input wire [width-1:0]a, 
		input wire [width-1:0]b,
		input wire [2:0]opcode,
		input wire shi_dir,

		output wire [width-1:0]result,
		output wire zero, 
		output wire carry, 
		output wire overflow,
		output wire negative
	);


endmodule
