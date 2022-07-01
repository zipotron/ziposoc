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

	wire [63:0] addr;
	wire [63:0]	byte_read;
	wire [63:0]	byte_write;
	wire [7:0] leds_io;
	wire rw;
	
	assign leds = led_switch? byte_read[7:0] : leds_io; //SHOUDNT KEEP ON LEDS, wires are misbehaving
	reg led_switch=0;
	
	data_bus data(.clk(clk_1khz), .rw(rw), .addr(addr), .read(byte_read), .write(byte_write), .led(leds_io), .exception(exception));
	
	zipocpu cpu(clk25_mhz, rw, addr, byte_write, byte_read);
	
	freq_div div(clk25_mhz, clk_1khz);
	defparam div.PERIOD = 30000;
	defparam div.PERIOD_WIDTH = 20;

endmodule
