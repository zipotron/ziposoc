`include "flash.v"
`include "ram.v"
`include "memory_map.v"

/*module io#(	parameter	csr_width = 8
 )
 (	input wire [2:0] rw_len,
	input wire [csr_width:0]	addr,
	output wire [31:0]		read,
	input wire [31:0] 		write,
	output reg  [7:0] led,
	output wire exception);

endmodule*/

module data_bus (input wire	rw,
				input wire	[1:0]len,
				input wire  [31:0] addr,
				input wire  [31:0] write,
				output wire  [31:0] read,
				output reg  [7:0] led,
				output wire exception);

	wire [31:0] write_io;
	//io core0_io ( .rw_len({rw,len}), .addr(addr), .read(read_io), .write(write_io) , .exception(exception));
	reg [31:0]read_csr = 2;//just for debug
	reg [31:0]read_io = 4;//just for debug
	reg [31:0]read_ram = 8;//just for debug
	reg [31:0]read_flash = 16;//just for debug
	
	/*ram	 core0_ram ( {rw,len}, addr, read_ram, write_ram, exception );
	defparam core0_ram.ram_width = 10;

	flash	 core0_flash ( addr, read_flash );
	defparam core0_flash.flash_width = 9;*/
	
	assign read = ~|addr[`DATA_RANGE] & addr[`DATA_TOKEN]? read_ram : ~|addr[`TEXT_RANGE] & addr[`TEXT_TOKEN]? read_flash : ~|addr[`IO_RANGE] & addr[`IO_TOKEN]? read_io : read_csr;
	
	assign write_ram = ~|addr[`DATA_RANGE] & addr[`DATA_TOKEN]? write : 0;
	assign write_flash = ~|addr[`TEXT_RANGE] & addr[`TEXT_TOKEN]? write : 0;
	assign write_io = ~|addr[`IO_RANGE] & addr[`IO_TOKEN]? write : 0;
	//assign write_csr = ~|addr[`CSR_RANGE]? write : 0;
	
	always @(addr)
		if (rw & ~|(addr ^ (`LEDS))) led <= write_io; //Like an ==
	
endmodule
