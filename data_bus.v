
module io#(	parameter	ram_width = 14,
			parameter	bus_width = 3
 )
 (			input clk,
			input rw,
			input [63:0] addr,
			input [63:0] write,
			output [63:0] read,
			output reg [7:0] led=0,
			output exception);
	
	//assign read = exception | rw? 0: ram_array[addr >> bus_width]; //Each cell have 8 bytes
	assign exception = |addr[63:ram_width + 1]? 1: 0; //Checking out of range
	reg [63:0]read_io = 62;//just for debug
	assign read = read_io;
	
	always @(addr)
		if (rw & ~|(addr ^ (`LEDS))) led <= write;
		
endmodule

module data_bus (input clk,
				input rw,
				input [63:0] addr,
				input [63:0] write,
				output [63:0] read,
				output [7:0] led,
				output exception);

	wire [63:0] write_io;
	io core0_io (.clk(clk), .rw(rw), .addr(addr), .read(read_io), .write(write_io) , .exception(exception), .led(led));
	
	wire [63:0] read_ram;
	
	wire [63:0] write_ram;
	
	wire exception_ram;
	wire exception_io;
	
	ram	 core_ram (clk, rw, addr, read_ram, write_ram, exception_ram );
	defparam core_ram.ram_width = 12;

	assign exception = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? exception_ram : ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? exception_io : exception_csr;
	
	assign read = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? read_ram : ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? read_io : read_csr;
	
	assign write_ram = ~|addr[`DATA_RANGE] & |addr[`DATA_TOKEN]? write : 0;
	assign write_io = ~|addr[`IO_RANGE] & |addr[`IO_TOKEN]? write : 0;
	
endmodule
