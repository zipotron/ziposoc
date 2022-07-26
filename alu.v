module alu (input [2:0] func,
				input sign,
				input [63:0] op_a,
				input [63:0] op_b,
				output [63:0] res);

	assign res = (op_a === 64'bx)? op_b : op_a + op_b;
endmodule
