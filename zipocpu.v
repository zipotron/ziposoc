`include "instr_decompress.v"

module zipocpu #(
	parameter EXTENSION_C = 1
) (	input	clk,
 );

	wire		clk;
	
	instr_decompress #(
		.PASSTHROUGH(!EXTENSION_C)
	) decomp (
		.instr_in       (fd_cir),
		.instr_is_32bit (d_instr_is_32bit),
		.instr_out      (d_instr),
		.invalid        (d_invalid_16bit)
	);

endmodule
