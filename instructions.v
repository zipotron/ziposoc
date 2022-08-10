//`define RV_COMPRESS_16_SET 0
`define RV_32_SET 2//Seams all RV64 instr are 32bit lenght for now
//`define RV_48_SET 5
//`define RV_64_SET 6
//`define RV_64PLUS_SET 7

// I extension

//                                     XXXXX-- [RV_32_SET 2]  
`define RV_ALU_REG_INSTR         5'b01100//
//                           0000000xxxxxxxxxx000xxxxx0110011
//`define RV_ADD         32'b00000000000000000000000000110011//R type
//`define RV_SUB         32'b01000000000000000000000000110011//R type
//`define RV_SLL         32'b00000000000000000001000000110011//R type
//`define RV_SLT         32'b00000000000000000010000000110011//R type
//`define RV_SLTU        32'b00000000000000000011000000110011//R type
//`define RV_XOR         32'b00000000000000000100000000110011//R type
//`define RV_SRL         32'b00000000000000000101000000110011//R type
//`define RV_SRA         32'b01000000000000000101000000110011//R type
//`define RV_OR          32'b00000000000000000110000000110011//R type
//`define RV_AND         32'b00000000000000000111000000110011//R type

`define RV_ALU_INM_INSTR         5'b00100//
//                            xxxxxxxxxxxxxxxxx000xxxxx0010011
//`define RV_ADDI         32'b00000000000000000000000000010011//I type
//`define RV_SLLI         32'b00000000000000000001000000010011//R type
//`define RV_SLTI         32'b00000000000000000010000000010011//I type
//`define RV_SLTIU        32'b00000000000000000011000000010011//I type
//`define RV_XORI         32'b00000000000000000100000000010011//I type
//`define RV_SRLI         32'b00000000000000000101000000010011//R type
//`define RV_SRAI         32'b01000000000000000101000000010011//R type
//`define RV_ORI          32'b00000000000000000110000000010011//I type
//`define RV_ANDI         32'b00000000000000000111000000010011//I type

`define F_ADD         3'b000
//`define F_SUB         3'b000
`define F_SLL         3'b001
`define F_SLT         3'b010
`define F_SLTU        3'b011
`define F_XOR         3'b100
`define F_SRL         3'b101
//`define F_SRA         3'b101
`define F_OR          3'b110
`define F_AND         3'b111

`define RV_CMP_INSTR         5'b11000//
//                           0000000xxxxxxxxxx000xxxxx1100011
//`define RV_BEQ         32'b00000000000000000000000001100011//SB type
//`define RV_BNE         32'b00000000000000000001000001100011//SB type
//`define RV_BLT         32'b00000000000000000100000001100011//SB type
//`define RV_BGE         32'b00000000000000000101000001100011//SB type
//`define RV_BLTU        32'b00000000000000000110000001100011//SB type
//`define RV_BGEU        32'b00000000000000000111000001100011//SB type

`define F_BEQ         3'b000
`define F_BNE         3'b001
`define F_BLT         3'b100
`define F_BGE         3'b101
`define F_BLTU        3'b110
`define F_BGEU        3'b111
