`timescale 1ns/1ps

// add, sub, and, or, xor, shift, 

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

	case(opcode)
	3'b000: result=a+b;
	3'b001: result=a-b;
	3'b010: result=



	default: 

	endcase


endmodule
