`include "memory_map.v"
//`timescale 1ns/10ps

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
	reg [31:0]	counter = 0;
	
	wire [31:0] addr;
	wire [7:0]	byte_read;
	wire [7:0]	byte_write;
	//reg [7:0]	byte_write;
	
	//reg len;
	//reg copy = 1;
	
	assign addr = clk_1khz? counter2 : counter;
	assign led = byte_read[7:0] | mask;
	//assign led = ~exception? byte_read[7:0] | mask : 0;
	assign byte_write = byte_read | 127;
	
	wire [7:0] mask;
	assign mask = 0;//copy? 0 : 21;
	
	data_bus data(.rw(clk_1khz), .len(2'b00), .addr(addr), .read(byte_read), .write(byte_write), .exception(exception));
	
	zipocpu cpu(clk);
	
	freq_div div(clk, clk_1khz);
	defparam div.PERIOD = 30000;
	defparam div.PERIOD_WIDTH = 20;
	
	/*always @(negedge clk)
		byte_write <= byte_read | 65;*/
	
	always @(posedge clk_1khz) 
		if (counter == `RAM_END) begin
			counter <= `RAM_INIT;
			mask <= 255;
		end
		else
			counter = counter + 1;
		
/*	always @(negedge clk_1khz)
		if (copy)
			counter2 <= counter2 + 1;*/
		
endmodule
