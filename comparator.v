module comparator (input [2:0] func,
				input [63:0] op_a,
				input [63:0] op_b,
				output res);

	assign res = (func == )?(op_a == op_b);
endmodule
