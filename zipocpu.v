`include "instructions.v"

module zipocpu #(parameter	initial_PC = `INITIAL_PC/*, parameter	initial_SP = `INITIAL_SP */
				)
				(input clk,
				output reg rw = 0,
				output reg [63:0] addr,
				output reg [63:0] write,
				input [63:0] read);

	reg [63:0]PC=initial_PC;
	reg [63:0]X[1:31];
	
	wire [63:0]zero; //Always zero
	wire [63:0]ra; //Return address
	wire [63:0]sp; //Stack pointer
	wire [63:0]gp; //Global pointer
	wire [63:0]tp; //Thread pointer
	wire [63:0]t0; //Temporary / alternate return address 	
	wire [63:0]t1; //Temporary
	wire [63:0]t2; //Temporary
	wire [63:0]s0; //Saved register / frame pointer
	wire [63:0]s1; //Saved register
	wire [63:0]a0; //Function argument / return value
	wire [63:0]a1; //Function argument / return value
	wire [63:0]a2; //Function argument
	wire [63:0]a3; //Function argument
	wire [63:0]a4; //Function argument
	wire [63:0]a5; //Function argument
	wire [63:0]a6; //Function argument
	wire [63:0]a7; //Function argument
	wire [63:0]s2; //Saved register
	wire [63:0]s3; //Saved register
	wire [63:0]s4; //Saved register
	wire [63:0]s5; //Saved register
	wire [63:0]s6; //Saved register
	wire [63:0]s7; //Saved register
	wire [63:0]s8; //Saved register
	wire [63:0]s9; //Saved register
	wire [63:0]s10; //Saved register
	wire [63:0]s11; //Saved register
	wire [63:0]t3; //Temporary
	wire [63:0]t4; //Temporary
	wire [63:0]t5; //Temporary
	wire [63:0]t6; //Temporary
	
	assign ra = X[1]; //Return address
	assign sp = X[2]; //Stack pointer
	assign gp = X[3]; //Global pointer
	assign tp = X[4]; //Thread pointer
	assign t0 = X[5]; //Temporary / alternate return address 	
	assign t1 = X[6]; //Temporary
	assign t2 = X[7]; //Temporary
	assign s0 = X[8]; //Saved register / frame pointer
	assign s1 = X[9]; //Saved register
	assign a0 = X[10]; //Function argument / return value
	assign a1 = X[11]; //Function argument / return value
	assign a2 = X[12]; //Function argument
	assign a3 = X[13]; //Function argument
	assign a4 = X[14]; //Function argument
	assign a5 = X[15]; //Function argument
	assign a6 = X[16]; //Function argument
	assign a7 = X[17]; //Function argument
	assign s2 = X[18]; //Saved register
	assign s3 = X[19]; //Saved register
	assign s4 = X[20]; //Saved register
	assign s5 = X[21]; //Saved register
	assign s6 = X[22]; //Saved register
	assign s7 = X[23]; //Saved register
	assign s8 = X[24]; //Saved register
	assign s9 = X[25]; //Saved register
	assign s10 = X[26]; //Saved register
	assign s11 = X[27]; //Saved register
	assign t3 = X[28]; //Temporary
	assign t4 = X[29]; //Temporary
	assign t5 = X[30]; //Temporary
	assign t6 = X[31]; //Temporary
	
	always @(posedge clk) begin
		addr <= PC;
		PC <= PC + 1;
		//if ({read[31:24], 18'b0000000000000000000000000, read[7:0]} == `RV_ADD)
		if (read[7:0] == `RV_ALU_INSTRUCTIONS)
			write <= PC;
	end
	
endmodule
