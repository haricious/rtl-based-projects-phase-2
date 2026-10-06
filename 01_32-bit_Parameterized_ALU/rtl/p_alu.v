`timescale 1ns/1ps

// add, sub, and, or, xor, shift, 

module p_alu #(
	parameter width = 32
)
	(
		input wire [width-1:0]a, 
		input wire [width-1:0]b,
		input wire [2:0]opcode,

		output reg [width-1:0]result,
		output wire zero, 
		output wire carry, 
		output wire overflow,
		output wire negative
	);

	localparam [2:0]op_add=3'b000;
	localparam [2:0]op_sub=3'b001;
	localparam [2:0]op_and=3'b010;
	localparam [2:0]op_or=3'b011;
	localparam [2:0]op_xor=3'b100;
	localparam [2:0]op_shi_r=3'b101;
	localparam [2:0]op_shi_l=3'b110
	localparam [2:0]op_comp=3'b111; 

	always@(*) begin
	case(opcode)
	
	op_add: result=a+b;
	op_sub: result=a-b;
	op_and: result=a&b;
	op_or: result=a


	default: 

	endcase

	end


endmodule
