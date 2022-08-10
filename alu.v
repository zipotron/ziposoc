module alu (input [2:0] func,
				input sign,
				input [63:0] op_a,
				input [63:0] op_b,
				output [63:0] res);

	assign res = ~|(func ^ `F_ADD) & ~sign?(op_a === 64'bx)? op_b : op_a + op_b:
				~|(func ^ `F_ADD) & sign?(op_a === 64'bx)? op_b : op_a - op_b://F_SUB
				~|(func ^ `F_XOR)?(op_a === 64'bx)? op_b : op_a ^ op_b:
				~|(func ^ `F_OR)?(op_a === 64'bx)? op_b : op_a | op_b:
				~|(func ^ `F_AND)?(op_a === 64'bx)? op_b : op_a & op_b:
				0;
endmodule

/* Pending to implement instructions:
`define F_SLL         3'b001
`define F_SLT         3'b010
`define F_SLTU        3'b011
`define F_SRL         3'b101
//`define F_SRA         3'b101*/
