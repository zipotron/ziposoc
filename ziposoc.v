`include "memory_map.v"

module freq_div #(parameter PERIOD=6000,
					parameter PERIOD_WIDTH=12) (input clk, output reg clk_1khz);
    reg [PERIOD_WIDTH:0] count = 0;
    always @(posedge clk)
     begin
        if(count == PERIOD)
            begin
                clk_1khz <= ~clk_1khz;
                count <= 0;
            end
        else
            count <= count + 1;
     end
endmodule

module ziposoc #(
	parameter EXTENSION_C = 1
) (	input	clk,
	output  [7:0] led);

	//reg [7:0]	led;
	reg [31:0]	counter = `FLASH_INIT;
	reg [31:0]	counter2 = `RAM_INIT;
	wire [31:0] addr;
	wire [7:0]	byte_read;
	wire [7:0]	byte_write;
	reg rw = 0;
	//reg len;
	reg copy = 1;
	
	assign addr = rw? counter2 : counter;
	assign led = byte_read[7:0] | mask;
	//assign led = ~exception? byte_read[7:0] | mask : 0;
	assign byte_write = byte_read;
	
	wire [7:0] mask;
	assign mask = 0;//copy? 0 : 21;
	
	data_bus data(.rw(rw), .len(2'b00), .addr(addr), .read(byte_read), .write(byte_write), .exception(exception));
	
	zipocpu cpu(clk);
	
	freq_div div(clk, clk_1khz);
	defparam div.PERIOD = 30000;
	defparam div.PERIOD_WIDTH = 20;
	
	always @(posedge clk_1khz) 
		if (copy) begin
			rw <= 0;
			if (counter == `FLASH_INIT + 260) begin
				counter <= `RAM_INIT;
				copy <= 0;
			end
			else
				counter <= counter + 1;
		end
		else begin
			rw <= 0;
			counter <= counter + 1;
		end
	
	always @(negedge clk_1khz)
		if (copy) begin
			rw <= 1;
			counter2 <= counter2 + 1;
		end

endmodule
