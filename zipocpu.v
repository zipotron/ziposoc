`include "instructions.v"
`define ALU_COMPARATOR_INSTR (~|(read_aux[7:`RV_32_SET] ^ `RV_ALU_REG_INSTR) | ~|(read_aux[7:`RV_32_SET] ^ `RV_CMP_INSTR))

module zipocpu #(parameter	initial_PC = `INITIAL_PC/*, parameter	initial_SP = `INITIAL_SP */
				)
				(
`ifdef DEBUG
				output wire [63:0]ra, //Return address
				output wire [63:0]sp, //Stack pointer
				output wire [63:0]gp, //Global pointer
				output wire [63:0]tp, //Thread pointer
				output wire [63:0]t0, //Temporary / alternate return address
				output wire [63:0]t1, //Temporary
				output wire [63:0]t2, //Temporary
				output wire [63:0]s0, //Saved register / frame pointer
				output wire [63:0]s1, //Saved register
				output wire [63:0]a0, //Function argument / return value
				output wire [63:0]a1, //Function argument / return value
				output wire [63:0]a2, //Function argument
				output wire [63:0]a3, //Function argument
				output wire [63:0]a4, //Function argument
				output wire [63:0]a5, //Function argument
				output wire [63:0]a6, //Function argument
				output wire [63:0]a7, //Function argument
				output wire [63:0]s2, //Saved register
				output wire [63:0]s3, //Saved register
				output wire [63:0]s4, //Saved register
				output wire [63:0]s5, //Saved register
				output wire [63:0]s6, //Saved register
				output wire [63:0]s7, //Saved register
				output wire [63:0]s8, //Saved register
				output wire [63:0]s9, //Saved register
				output wire [63:0]s10, //Saved register
				output wire [63:0]s11, //Saved register
				output wire [63:0]t3, //Temporary
				output wire [63:0]t4, //Temporary
				output wire [63:0]t5, //Temporary
				output wire [63:0]t6, //Temporary
`endif
				input clk,
				output reg rw = 0,
				output reg [63:0] addr,
				output reg [63:0] write,
				input [63:0] read);

	reg [63:0]PC=initial_PC;
	reg [63:0]X[1:31];
	
	wire [63:0]zero; //Always zero
	assign zero = 0;
	
`ifdef DEBUG
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
`endif

	reg pc_hooker = 0;
	wire [31:0] read_aux;
	assign read_aux = pc_hooker? read[63:32]: read[31:0];
	
	wire [2:0] func;
	wire sign;
	wire [63:0] op_a;
	wire [63:0] op_b;
	wire [63:0] res;
	
	assign func = (`ALU_COMPARATOR_INSTR | ~|(read_aux[7:`RV_32_SET] ^ `RV_ALU_INM_INSTR))? read_aux[14:12] :0;
	assign sign = ~|(read_aux[7:`RV_32_SET] ^ `RV_ALU_REG_INSTR)? read_aux[30] :0;
	assign op_a = (`ALU_COMPARATOR_INSTR | ~|(read_aux[7:`RV_32_SET] ^ `RV_ALU_INM_INSTR))? X[read_aux[19:15]] :0;
	assign op_b = `ALU_COMPARATOR_INSTR? X[read_aux[24:20]] :
										~|(read_aux[7:`RV_32_SET] ^ `RV_ALU_INM_INSTR)? read_aux[31:20] :0;

	alu alu_1(func, sign, op_a, op_b, res);
	
	always @(posedge clk) begin
		pc_hooker <= ~pc_hooker;
		addr <= PC;
		PC <= PC + 4;
		//if ({read_aux[31:24], 18'b0000000000000000000000000, read_aux[7:0]} == `RV_ADD)
		if ((read_aux[7:`RV_32_SET] == `RV_ALU_REG_INSTR) || (read_aux[7:`RV_32_SET] == `RV_ALU_INM_INSTR)) begin
			X[read_aux[11:7]] <= res;
			write <= res;
		end
	end
	
endmodule
