`include "instructions.v"

module zipocpu (input	clk);

	ram	 csr_ram (clk, rw, addr, read_csr, write_csr, exception_csr );
	defparam csr_ram.ram_width = 6;
	
endmodule
