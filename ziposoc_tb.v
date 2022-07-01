`include "memory_map.v"

module test;

  /* Make a reset that pulses once. */	
	wire [63:0] addr;
	wire [63:0]	byte_read;
	wire [63:0]	byte_write;
	wire  [7:0] led;
	wire rw;
	
  initial begin
	$dumpfile("ziposoc_tb.vcd");
	$dumpvars(0, addr);
	$dumpvars(1, byte_read);
/*     # 17 copy = 0;
	 # 25 led = 8'b10110110;
     # 100 $finish;*/
  end

  /* Make a regular pulsing clock. */
  reg clk_1khz = 0;
  always #5 clk_1khz = !clk_1khz;

  data_bus data(.clk(clk_1khz), .rw(rw), .addr(addr), .read(byte_read), .write(byte_write), .exception(exception));
  zipocpu cpu(clk25_mhz, rw, addr, byte_write, byte_read);
  
  always @(posedge clk_1khz) 
		if (addr == `MEM_END)
			$finish;
		else
		  begin
			$dumpvars(0, addr);
			$dumpvars(1, byte_read);
		  end

/*  initial
     $monitor("At time %t, value = %h (%0d)",
              $time, counter, counter);*/
endmodule // test
