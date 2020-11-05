module flash
 #(	parameter	flash_width = 9
 )
 (	input	[flash_width+2:0]	addr,
	output	[31:0]			data
 );

reg [31:0] flash_array [0:2**flash_width];

initial begin
	`include "flash_array.v"
end

assign data = flash_array[addr>>2];

endmodule
