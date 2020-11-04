module ram
 #(	parameter	ram_width = 10
 )
 (	input	clk,
	input	rw,
	input	[ram_width-1:0]	addr,
	output	[7:0]		data_read,
	input	[7:0] 		data_write
 );

reg [7:0] ram_array [0:2**ram_width];
reg [7:0] data_out;
        
assign data_read = data_out;
        
always @(posedge clk) begin
	if (rw) ram_array[addr] <= data_write;
end

always @(posedge clk) begin
	if (~rw) data_out <= ram_array[addr];
end

endmodule
