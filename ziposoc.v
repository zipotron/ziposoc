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
	
	data_bus data(1, 2'b00, LEDS, 8'b01010111, 0, led);
	
	zipocpu cpu(clk);

endmodule
