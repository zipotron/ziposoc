`include "flash.v"
`include "ram.v"

module data_bus (input	rw,
				input	[1:0]len,
				input  [31:0] addr,
				input  [31:0] write,
				output  [31:0] read,
				output  [7:0] led);

	wire		clk;
	wire		rw;
	wire [1:0]len;
	wire [31:0]	addr;
	wire [31:0] write;
	wire [31:0] read;
	reg [7:0] led;

	ram	 core0_ram ( {rw,len}, addr, read, write );
	defparam core0_ram.ram_width = 10;

	flash	 core0_flash ( addr, read );
	defparam core0_flash.flash_width = 9;
	
endmodule
