`define DEBUG 1
`include "zipocpu.v"

module test;

  /* Make a reset that pulses once. */	
	wire [63:0] addr;
	wire [63:0]	byte_read;
	wire [63:0]	byte_write;
	wire  [7:0] led;
	wire rw;
	
	wire [63:0]a0; //Function argument / return value
	wire [63:0]a1; //Function argument / return value
	wire [63:0]a2; //Function argument
	wire [63:0]a3; //Function argument
	wire [63:0]a4; //Function argument
	wire [63:0]a5; //Function argument
	wire [63:0]a6; //Function argument
	wire [63:0]a7; //Function argument
	
  initial begin
	$dumpfile("zipocpu_tb.vcd");
	$dumpvars(0, addr);
	$dumpvars(1, byte_read);
	$dumpvars(2, byte_write);
	$dumpvars(3, a0);
	$dumpvars(4, a1);
	$dumpvars(5, a2);
	$dumpvars(6, a3);
	$dumpvars(7, a4);
	$dumpvars(8, a5);
	$dumpvars(9, a6);
	$dumpvars(10, a7);
	
/*     # 17 copy = 0;
	 # 25 led = 8'b10110110;
     # 100 $finish;*/
  end

  /* Make a regular pulsing clock. */
  reg clk_1khz = 0;
  always #5 clk_1khz = !clk_1khz;

  ram_tb ram(.clk(clk_1khz), .rw(rw), .addr(addr), .read(byte_read), .write(byte_write), .exception(exception));
  zipocpu cpu(.clk(clk_1khz), .rw(rw), .addr(addr), .write(byte_write), .read(byte_read), .a0(a0), .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5), .a6(a6), .a7(a7));
  
  always @(posedge clk_1khz) 
		if (addr == `MEM_END)
			$finish;
		else
		  begin
			$display("Addr: %b", addr);
			//$display("Read: %b", byte_read);
		  end

/*  initial
     $monitor("At time %t, value = %h (%0d)",
              $time, counter, counter);*/
endmodule // test
