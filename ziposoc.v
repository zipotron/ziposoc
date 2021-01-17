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
) (	input	clk25_mhz,
	output  [7:0] leds);

	reg [31:0]	counter = `INITIAL_SP;
	
	wire [31:0] addr;
	wire [7:0]	byte_read;
	wire [7:0]	byte_write;
	//reg [7:0]	byte_write;
	
	//reg len;
	reg copy = 1;
	
	//assign addr = clk_1khz? counter2 : counter;
	assign leds = byte_read[7:0] | mask;
	//assign leds = ~exception? byte_read[7:0] | mask : 0;
	assign byte_write = byte_read | 224;
	
	reg [7:0] mask=0;
	//assign mask = 0;//copy? 0 : 21;
	
	data_bus data(.clk(clk_1khz), .rw(copy), .len(2'b00), .addr(counter), .read(byte_read), .write(byte_write), .exception(exception));
	
	zipocpu cpu(clk25_mhz);
	
	freq_div div(clk25_mhz, clk_1khz);
	defparam div.PERIOD = 30000;
	defparam div.PERIOD_WIDTH = 20;
	
	/*always @(negedge clk25_mhz)
		byte_write <= byte_read | 65;*/
	
	always @(posedge clk_1khz) 
		if (counter == `MEM_END) begin
			counter <= 0;
			copy <= 0;
			if(copy==0)mask <= 255;
		end
		else
			counter <= counter + 1;
		
/*	always @(negedge clk_1khz)
		if (copy)
			counter2 <= counter2 + 1;*/
		
endmodule
