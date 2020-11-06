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
	
	//reg [7:0]	led;
	reg [31:0]	counter = 0;
	reg [7:0]	byte_read;
	reg [7:0]	byte_write;
	reg rw = 0;
	//reg len;
	
	data_bus data(.rw(rw), .len(2'b00), .addr(32'h00000040), .read(led), .write(byte_write));
	//data_bus data(.rw(1), .len(2'b00), .addr(32'h00000004), .write(8'b01010111), .led(led));
	
	zipocpu cpu(clk);
	
	/*always @(posedge clk) begin
		
	end*/

endmodule
