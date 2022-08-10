module comparator (input [2:0] func,
				input [63:0] op_a,
				input [63:0] op_b,
				output res);
	wire signed a = op_a;
	wire signed b = op_b;
	
	assign res = ~|(func ^ `F_BEQ)? (op_a == op_b):
				~|(func ^ `F_BNE)? ~(op_a == op_b):
				~|(func ^ `F_BLT)? (a < b):
				~|(func ^ `F_BGE)? (a >= b):
				~|(func ^ `F_BLTU)? (op_a < op_b)://Unsigned comparation
				~|(func ^ `F_BGEU)? (op_a >= op_b)://Unsigned comparation
				0;
endmodule
