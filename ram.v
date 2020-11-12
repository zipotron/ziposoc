module ram
 #(	parameter	ram_width = 10
 )
 (	input wire rw,
	input wire [1:0] len,
	input wire [31:0]	addr,
	output wire [31:0]		read,
	input wire [31:0] 		write,
	output wire exception
 );

reg [7:0] ram_array [0:2**ram_width];
       
assign read = exception | rw? 0: ram_array[addr];//exception | rw[2]? 0 : ~|rw_len[1:0]? {ram_array[addr], 24'b0} : ~rw_len[2] & ~rw_len[1] & rw_len[0]? {ram_array[addr],ram_array[addr+1], 16'b0} : ~rw_len[2] & rw_len[1] & ~rw_len[0]? {ram_array[addr],ram_array[addr+1],ram_array[addr+2],ram_array[addr+3]} : 0;

assign exception = |addr[31:ram_width + 1]? 1: 0;//~|rw_len[1:0]? 0: ~rw_len[1] & rw_len[0] &addr[0]? 0: rw_len[1] & ~rw_len[0] & ~|addr[1:0]? 0: 1;

always @(addr, rw) begin
	if (rw & ~exception) begin
		/*case (rw_len[1:0])
			2'b00:*/
				ram_array[addr] <= 255;//write;
			/*2'b01: begin
				ram_array[addr] <= write;
				ram_array[addr+1] <= write[15:8];
			end
			2'b10: begin
				ram_array[addr] <= write;
				ram_array[addr+1] <= write[15:8];
				ram_array[addr+2] <= write[23:16];
				ram_array[addr+3] <= write[31:24];
			end
		endcase*/
	end
end

endmodule
