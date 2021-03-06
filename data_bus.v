
/*module io#(	parameter	csr_width = 8
 )
 (	input wire [2:0] rw_len,
	input wire [csr_width:0]	addr,
	output wire [31:0]		read,
	input wire [31:0] 		write,
	output reg  [7:0] led,
	output wire exception);

endmodule*/

module data_bus (input clk,
				input wire	rw,
				input [1:0]len,
				input [31:0] addr,
				input [31:0] write,
				output wire  [31:0] read,
				output reg  [7:0] led,
				output wire exception);

	wire [31:0] write_io;
	//io core0_io ( .rw_len({rw,len}), .addr(addr), .read(read_io), .write(write_io) , .exception(exception));
	reg [31:0]read_csr = 127;//just for debug
	//reg [31:0]read_ram = 4;//just for debug
	reg [31:0]read_io = 128;//just for debug
	
	wire [31:0] read_ram;
	
	wire [31:0] write_ram;
	
	wire exception_ram;
	wire exception_io;
	wire exception_csr;
	
	ram	 core0_ram (clk, rw, len, addr, read_ram, write_ram, exception_ram );
	defparam core0_ram.ram_width = 12;

	assign exception = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? exception_ram : ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? exception_io : exception_csr;
	
	assign read = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? read_ram : ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? read_io : read_csr;
	
	assign write_ram = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? write : 0;
	
	assign write_io = ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? write : 0;
	//assign write_csr = ~|addr[`CSR_RANGE]? write : 0;
	
	always @(addr)
		if (rw & ~|(addr ^ (`LEDS))) led <= write_io; //Like an ==
	
endmodule
