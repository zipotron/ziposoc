`include "flash.v"
`include "ram.v"

module data_bus (input	clk,
				output  [31:0] addr);

	wire		clk;
	wire [31:0]	addr;
	
	parameter	flash_width = 9;
	parameter	ram_width = 10;

	wire [flash_width-1:0]	flash_addr;
	wire [31:0]		flash_data;

	wire			ram_rw;
	wire [ram_width-1:0] 	ram_addr;
	wire [7:0]		ram_di;
	wire [7:0]		ram_do;

	ram	 core0_ram ( clk, ram_rw, ram_addr, ram_di, ram_do );
	defparam core0_ram.ram_width = ram_width;

	flash	 core0_flash ( flash_addr, flash_data );
	defparam core0_flash.flash_width = flash_width;
	
endmodule
