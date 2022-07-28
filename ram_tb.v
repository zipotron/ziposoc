module ram_tb
 #(	parameter	ram_width = 12,
	parameter	bus_width = 3
 )
 (	input clk,
	input rw,
	input [63:0]	addr,
	output [63:0]		read,
	input [63:0] 		write,
	output exception
 );
	integer i;
	reg [63:0] ram_array [0:2**(ram_width - bus_width)];
	initial begin
		for(i=0; i<2**(ram_width - bus_width); i=i+1) begin
			ram_array[i]=0;
		end
		ram_array[0]=64'h0fc1059700100513;
		ram_array[1]=64'h00d0061300d00613;
		ram_array[2]=64'h0000007304000893;
		ram_array[3]=64'h05d0089300000513;
		ram_array[4]=64'h01c0006ffe042623;
	end
	
	assign read = exception | rw? 0: ram_array[addr >> bus_width]; //Each cell have 8 bytes
	assign exception = |addr[63:ram_width + 1]? 1: 0; //Checking out of range
	
	always @(posedge clk) begin
		if (rw & ~exception)
			ram_array[addr] <= write;
	end

endmodule
