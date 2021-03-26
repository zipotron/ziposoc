module ram
 #(	parameter	ram_width = 12
 )
 (	input clk,
	input rw,
	input [1:0] len,
	input [31:0]	addr,
	output wire [31:0]		read,
	input [31:0] 		write,
	output wire exception
 );
	integer i;
	reg [7:0] ram_array [0:2**ram_width];
	initial begin
		`include "flash_array.vh"
		for(i=`INITIAL_SP;i<`IO_INIT;i=i+1) begin
			ram_array[i]=0;
		end
	end
	
	assign read = exception | rw? 0: ram_array[addr];
	assign exception = |addr[31:ram_width + 1]? 1: 0;
	
	always @(posedge clk) begin
		if (rw & ~exception) begin
			/*case (len[1:0])
				2'b00:*/
					ram_array[addr] <= write;
				/*2'b01: begin
					ram_array[addr] = write;
					ram_array[addr+1] = write[15:8];
				end
				2'b10: begin
					ram_array[addr] = write;
					ram_array[addr+1] = write[15:8];
					ram_array[addr+2] = write[23:16];
					ram_array[addr+3] = write[31:24];
				end
			endcase*/
		end
	end

endmodule
