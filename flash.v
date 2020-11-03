module flash
 #(	parameter	flash_width = 10
 )
 (	input				clk,
	input				mem_ce,
	input	[flash_width-1:0]	mem_a,
	output	[31:0]			mem_d
 );

reg [31:0] flash_array [0:2**flash_width-1];

initial begin
	`include "flash_array.v"
end

reg [31:0] data_read;

assign mem_d = data_read;

always @(posedge clk) begin
	if (mem_ce) data_read <= flash_array[mem_a];
end

endmodule
