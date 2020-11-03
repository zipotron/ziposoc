`include "flash.v"
`include "ram.v"

module ziposoc
 (	input	clk,
	output  [7:0] led,
 );

	wire		clk;

	parameter	pmem_width = 10;
	parameter	dmem_width = 9;

	wire			pmem_ce;
	wire [pmem_width-1:0]	pmem_a;
	wire [15:0]		pmem_d;

	wire			dmem_re;
	wire			dmem_we;
	wire [dmem_width-1:0] 	dmem_a;
	wire [7:0]		dmem_di;
	wire [7:0]		dmem_do;

	ram	 core0_ram ( clk, dmem_re, dmem_we, dmem_a, dmem_di, dmem_do );
	defparam core0_ram.ram_width = dmem_width;

	flash	 core0_flash ( clk, pmem_ce,pmem_a, pmem_d );
endmodule
