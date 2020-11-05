module ram
 #(	parameter	ram_width = 10
 )
 (	input wire [2:0] rw_len,
	input wire [ram_width:0]	addr,
	output wire [31:0]		read,
	input wire [31:0] 		write,
	output reg exception
 );

reg [7:0] ram_array [0:2**ram_width];

wire [31:0]data_write;//mierda
        
assign read = exception & rw[2]? 0 : ~|rw_len[1:0]? {24'b0,ram_array[addr]} : ~rw_len[2] & ~rw_len[1] & rw_len[0]? {16'b0,ram_array[addr],ram_array[addr+1]} : ~rw_len[2] & rw_len[1] & ~rw_len[0]? {ram_array[addr],ram_array[addr+1],ram_array[addr+2],ram_array[addr+3]} : 0;

assign exception = ~|rw_len[1:0]? 0: ~rw_len[1] & rw_len[0] &addr[0]? 0: rw_len[1] & ~rw_len[0] & ~|addr[1:0]? 0: 1;

always @(*) begin
	if (rw_len[2] & ~exception) begin
		case (rw_len[1:0])
			2'b00:
				ram_array[addr] <= write;
			2'b01: begin
				ram_array[addr] <= write;
				ram_array[addr+1] <= write[15:8];
			end
			2'b10: begin
				ram_array[addr] <= write;
				ram_array[addr+1] <= write[15:8];
				ram_array[addr+2] <= write[23:16];
				ram_array[addr+3] <= write[31:24];
			end
		endcase
	end
end

endmodule
