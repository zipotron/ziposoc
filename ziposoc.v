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

	reg [63:0]	counter = `INITIAL_SP;
	
	wire [63:0] addr;
	wire [63:0]	byte_read;
	reg [63:0]	byte_write;
	wire [7:0] leds_io;
	reg w_flag = 0;
	
	assign leds = led_switch? byte_read[7:0] : 0;//leds_io; //SHOUDNT KEEP ON LEDS, wires are misbehaving
	
	reg led_switch=0;
	
	data_bus data(.clk(clk_1khz), .rw(w_flag), .addr(counter), .read(byte_read), .write(byte_write), .led(leds_io), .exception(exception));
	
	zipocpu cpu(clk25_mhz);
	
	freq_div div(clk25_mhz, clk_1khz);
	defparam div.PERIOD = 30000;
	defparam div.PERIOD_WIDTH = 20;
	
	always @(negedge clk_1khz)
	  begin
		//byte_write <= byte_read | 65;
		w_flag <= 0;
	  end
	
	always @(posedge clk_1khz) 
		if (counter == `MEM_END) begin
			w_flag <= 0;
			led_switch <= 1;
		end
		else
		  begin
			counter <= counter + 1;
			//w_flag <= 1;
		  end

endmodule
