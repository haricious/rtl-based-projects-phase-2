module p_alu #(
	parameter WIDTH = 32
) (
	input wire [WIDTH-1:0] a,
	input wire [WIDTH-1:0] b,
	input wire [3:0] opcode,
	output reg [WIDTH-1:0] result,
	output wire zero
);

	localparam [3:0] OP_ADD  = 4'h0;
	localparam [3:0] OP_SUB  = 4'h1;
	localparam [3:0] OP_AND  = 4'h2;
	localparam [3:0] OP_OR   = 4'h3;
	localparam [3:0] OP_XOR  = 4'h4;
	localparam [3:0] OP_NOT  = 4'h5;
	localparam [3:0] OP_SLT  = 4'h6;
	localparam [3:0] OP_SLTU = 4'h7;
	localparam [3:0] OP_SLL  = 4'h8;
	localparam [3:0] OP_SRL  = 4'h9;
	localparam [3:0] OP_SRA  = 4'hA;
	localparam [3:0] OP_NOR  = 4'hB;
	localparam [3:0] OP_NAND = 4'hC;
	localparam [3:0] OP_XNOR = 4'hD;
	localparam [3:0] OP_PASS = 4'hE;

	always @* begin
		case (opcode)
			OP_ADD:  result = a + b;
			OP_SUB:  result = a - b;
			OP_AND:  result = a & b;
			OP_OR:   result = a | b;
			OP_XOR:  result = a ^ b;
			OP_NOT:  result = ~a;
			OP_SLT:  result = {{(WIDTH-1){1'b0}}, ($signed(a) < $signed(b))};
			OP_SLTU: result = {{(WIDTH-1){1'b0}}, (a < b)};
			OP_SLL:  result = a << b;
			OP_SRL:  result = a >> b;
			OP_SRA:  result = $signed(a) >>> b;
			OP_NOR:  result = ~(a | b);
			OP_NAND: result = ~(a & b);
			OP_XNOR: result = ~(a ^ b);
			OP_PASS: result = b;
			default: result = {WIDTH{1'b0}};
		endcase
	end

	assign zero = (result == {WIDTH{1'b0}});

endmodule
