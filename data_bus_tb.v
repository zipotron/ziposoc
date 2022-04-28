`include "memory_map.v"

module test;

  /* Make a reset that pulses once. */
	reg [63:0]	counter = `INITIAL_PC;
	
	wire [63:0] addr;
	wire [63:0]	byte_read;
	wire [63:0]	byte_write;
	wire  [7:0] led;
	reg copy = 0;
	
  initial begin
	$dumpfile("data_bus_tb.vcd");
/*     # 17 copy = 0;
	 # 25 led = 8'b10110110;
     # 100 $finish;*/
  end

  /* Make a regular pulsing clock. */
  reg clk_1khz = 0;
  always #5 clk_1khz = !clk_1khz;

  data_bus data(.clk(clk_1khz), .rw(copy), .addr(counter), .read(byte_read), .write(byte_write), .exception(exception));
  
  always @(posedge clk_1khz) 
		if (counter == `MEM_END)
			$finish;
		else
		  begin
			counter <= counter + 1;
			$dumpvars(0, counter);
			$dumpvars(1, byte_read);
		  end

/*  initial
     $monitor("At time %t, value = %h (%0d)",
              $time, counter, counter);*/
endmodule // test
