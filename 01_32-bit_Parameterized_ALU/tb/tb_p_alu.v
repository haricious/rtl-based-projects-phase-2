`timescale 1ns/1ps

module tb_p_alu;

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

	reg [31:0] a32;
	reg [31:0] b32;
	reg [3:0] opcode32;
	wire [31:0] result32;
	wire zero32;

	reg [7:0] a8;
	reg [7:0] b8;
	reg [3:0] opcode8;
	wire [7:0] result8;
	wire zero8;

	integer errors;

	p_alu #(.WIDTH(32)) dut32 (
		.a(a32), .b(b32), .opcode(opcode32), .result(result32), .zero(zero32)
	);

	p_alu #(.WIDTH(8)) dut8 (
		.a(a8), .b(b8), .opcode(opcode8), .result(result8), .zero(zero8)
	);

	task check32;
		input [3:0] operation;
		input [31:0] operand_a;
		input [31:0] operand_b;
		input [31:0] expected;
		begin
			opcode32 = operation;
			a32 = operand_a;
			b32 = operand_b;
			#1;
			if (result32 !== expected || zero32 !== (expected == 32'b0)) begin
				$display("FAIL 32-bit op=%h a=%h b=%h got=%h zero=%b expected=%h",
						 operation, operand_a, operand_b, result32, zero32, expected);
				errors = errors + 1;
			end
		end
	endtask

	task check8;
		input [3:0] operation;
		input [7:0] operand_a;
		input [7:0] operand_b;
		input [7:0] expected;
		begin
			opcode8 = operation;
			a8 = operand_a;
			b8 = operand_b;
			#1;
			if (result8 !== expected || zero8 !== (expected == 8'b0)) begin
				$display("FAIL 8-bit op=%h a=%h b=%h got=%h zero=%b expected=%h",
						 operation, operand_a, operand_b, result8, zero8, expected);
				errors = errors + 1;
			end
		end
	endtask

	initial begin
		errors = 0;
		a32 = 0;
		b32 = 0;
		opcode32 = 0;
		a8 = 0;
		b8 = 0;
		opcode8 = 0;

		check32(OP_ADD, 32'h7FFF_FFFF, 32'h0000_0001, 32'h8000_0000);
		check32(OP_SUB, 32'h0000_0003, 32'h0000_0005, 32'hFFFF_FFFE);
		check32(OP_AND, 32'hA5A5_5A5A, 32'h0F0F_F0F0, 32'h0505_5050);
		check32(OP_OR,  32'hA5A5_5A5A, 32'h0F0F_F0F0, 32'hAFAF_FAFA);
		check32(OP_XOR, 32'hAAAA_5555, 32'hFFFF_00FF, 32'h5555_55AA);
		check32(OP_NOT, 32'h0000_00FF, 32'h0,          32'hFFFF_FF00);
		check32(OP_SLT, 32'hFFFF_FFFF, 32'h0000_0001, 32'h0000_0001);
		check32(OP_SLT, 32'h0000_0001, 32'hFFFF_FFFF, 32'h0000_0000);
		check32(OP_SLTU,32'hFFFF_FFFF, 32'h0000_0001, 32'h0000_0000);
		check32(OP_SLTU,32'h0000_0001, 32'hFFFF_FFFF, 32'h0000_0001);
		check32(OP_SLL, 32'h0000_0001, 32'd31,       32'h8000_0000);
		check32(OP_SRL, 32'h8000_0000, 32'd31,       32'h0000_0001);
		check32(OP_SRA, 32'h8000_0000, 32'd31,       32'hFFFF_FFFF);
		check32(OP_NOR, 32'hFFFF_0000, 32'h0000_FFFF, 32'h0000_0000);
		check32(OP_NAND,32'hFFFF_FFFF, 32'hFFFF_FFFF, 32'h0000_0000);
		check32(OP_XNOR,32'hAAAA_AAAA, 32'h5555_5555, 32'h0000_0000);
		check32(OP_PASS,32'h1234_5678, 32'hDEAD_BEEF, 32'hDEAD_BEEF);
		check32(4'hF,   32'hFFFF_FFFF, 32'hFFFF_FFFF, 32'h0000_0000);

		check8(OP_ADD, 8'hFF, 8'h01, 8'h00);
		check8(OP_SUB, 8'h00, 8'h01, 8'hFF);
		check8(OP_AND, 8'hA5, 8'h3C, 8'h24);
		check8(OP_OR,  8'hA5, 8'h3C, 8'hBD);
		check8(OP_XOR, 8'hA5, 8'h3C, 8'h99);
		check8(OP_NOT, 8'h00, 8'h00, 8'hFF);
		check8(OP_SLT, 8'h80, 8'h01, 8'h01);
		check8(OP_SLTU,8'h80, 8'h01, 8'h00);
		check8(OP_SLL, 8'h01, 8'd7,  8'h80);
		check8(OP_SRL, 8'h80, 8'd7,  8'h01);
		check8(OP_SRA, 8'h80, 8'd7,  8'hFF);
		check8(OP_SLL, 8'hFF, 8'd8,  8'h00);
		check8(OP_SRL, 8'hFF, 8'd8,  8'h00);
		check8(OP_SRA, 8'h80, 8'd8,  8'hFF);
		check8(OP_NOR, 8'hF0, 8'h0F, 8'h00);
		check8(OP_NAND,8'hFF, 8'hFF, 8'h00);
		check8(OP_XNOR,8'hAA, 8'h55, 8'h00);
		check8(OP_PASS,8'h12, 8'h34, 8'h34);
		check8(4'hF,   8'hFF, 8'hFF, 8'h00);

		if (errors == 0) begin
			$display("PASS: all parameterized ALU tests passed");
		end else begin
			$display("FAIL: %0d ALU test(s) failed", errors);
			$fatal(1);
		end
		$finish;
	end

endmodule
