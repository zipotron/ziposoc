
module zipocpu #(
	parameter EXTENSION_C = 1
) (input	clk);

	instr_decompress #(.PASSTHROUGH(!EXTENSION_C)) decomp (
		.instr_in       (fd_cir),
		.instr_is_32bit (d_instr_is_32bit),
		.instr_out      (d_instr),
		.invalid        (d_invalid_16bit)
	);
	
		
	ram	 csr_ram (clk, rw, addr, read_csr, write_csr, exception_csr );
	defparam csr_ram.ram_width = 6;
	
endmodule
