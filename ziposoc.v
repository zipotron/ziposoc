`include "memory_map.v"
`include "data_bus.v"
`include "zipocpu.v"

module ziposoc #(
	parameter EXTENSION_C = 1
) (	input	clk,
	output  [7:0] led,
 );

	wire		clk;
	wire [7:0]	led;
	
	reg [31:0] io_mapped;
	assign led = io_mapped[7:0];
	
	data_bus data(clk, LEDS);
	
	zipocpu cpu(clk);

endmodule
