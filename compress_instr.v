// C Extension
`define RV_C_ADDI4SPN  = 16'b000???????????00; // *** illegal if imm 0
`define RV_C_LW        = 16'b010???????????00;
`define RV_C_SW        = 16'b110???????????00;

`define RV_C_ADDI      = 16'b000???????????01;
`define RV_C_JAL       = 16'b001???????????01;
`define RV_C_J         = 16'b101???????????01;
`define RV_C_LI        = 16'b010???????????01;
// addi16sp when rd=2:
`define RV_C_LUI       = 16'b011???????????01; // *** reserved if imm 0 (for both LUI and ADDI16SP)
`define RV_C_SRLI      = 16'b100000????????01; // On RV32 imm[5] (instr[12]) must be 0, else reserved NSE.
`define RV_C_SRAI      = 16'b100001????????01; // On RV32 imm[5] (instr[12]) must be 0, else reserved NSE.
`define RV_C_ANDI      = 16'b100?10????????01;
`define RV_C_SUB       = 16'b100011???00???01;
`define RV_C_XOR       = 16'b100011???01???01;
`define RV_C_OR        = 16'b100011???10???01;
`define RV_C_AND       = 16'b100011???11???01;
`define RV_C_BEQZ      = 16'b110???????????01;
`define RV_C_BNEZ      = 16'b111???????????01;

`define RV_C_SLLI      = 16'b0000??????????10; // On RV32 imm[5] (instr[12]) must be 0, else reserved NSE.
// jr if !rs2:
`define RV_C_MV        = 16'b1000??????????10; // *** reserved if JR and !rs1 (instr[11:7])
// jalr if !rs2:
`define RV_C_ADD       = 16'b1001??????????10; // *** EBREAK if !instr[11:2]
`define RV_C_LWSP      = 16'b010???????????10;
`define RV_C_SWSP      = 16'b110???????????10;

// Copies provided here with 0 instead of ? so that these can be used to build 32-bit instructions in the decompressor

`define RV_NOZ_BEQ         = 32'b00000000000000000000000001100011;
`define RV_NOZ_BNE         = 32'b00000000000000000001000001100011;
`define RV_NOZ_BLT         = 32'b00000000000000000100000001100011;
`define RV_NOZ_BGE         = 32'b00000000000000000101000001100011;
`define RV_NOZ_BLTU        = 32'b00000000000000000110000001100011;
`define RV_NOZ_BGEU        = 32'b00000000000000000111000001100011;
`define RV_NOZ_JALR        = 32'b00000000000000000000000001100111;
`define RV_NOZ_JAL         = 32'b00000000000000000000000001101111;
`define RV_NOZ_LUI         = 32'b00000000000000000000000000110111;
`define RV_NOZ_AUIPC       = 32'b00000000000000000000000000010111;
`define RV_NOZ_ADDI        = 32'b00000000000000000000000000010011;
`define RV_NOZ_SLLI        = 32'b00000000000000000001000000010011;
`define RV_NOZ_SLTI        = 32'b00000000000000000010000000010011;
`define RV_NOZ_SLTIU       = 32'b00000000000000000011000000010011;
`define RV_NOZ_XORI        = 32'b00000000000000000100000000010011;
`define RV_NOZ_SRLI        = 32'b00000000000000000101000000010011;
`define RV_NOZ_SRAI        = 32'b01000000000000000101000000010011;
`define RV_NOZ_ORI         = 32'b00000000000000000110000000010011;
`define RV_NOZ_ANDI        = 32'b00000000000000000111000000010011;
`define RV_NOZ_ADD         = 32'b00000000000000000000000000110011;
`define RV_NOZ_SUB         = 32'b01000000000000000000000000110011;
`define RV_NOZ_SLL         = 32'b00000000000000000001000000110011;
`define RV_NOZ_SLT         = 32'b00000000000000000010000000110011;
`define RV_NOZ_SLTU        = 32'b00000000000000000011000000110011;
`define RV_NOZ_XOR         = 32'b00000000000000000100000000110011;
`define RV_NOZ_SRL         = 32'b00000000000000000101000000110011;
`define RV_NOZ_SRA         = 32'b01000000000000000101000000110011;
`define RV_NOZ_OR          = 32'b00000000000000000110000000110011;
`define RV_NOZ_AND         = 32'b00000000000000000111000000110011;
`define RV_NOZ_LB          = 32'b00000000000000000000000000000011;
`define RV_NOZ_LH          = 32'b00000000000000000001000000000011;
`define RV_NOZ_LW          = 32'b00000000000000000010000000000011;
`define RV_NOZ_LBU         = 32'b00000000000000000100000000000011;
`define RV_NOZ_LHU         = 32'b00000000000000000101000000000011;
`define RV_NOZ_SB          = 32'b00000000000000000000000000100011;
`define RV_NOZ_SH          = 32'b00000000000000000001000000100011;
`define RV_NOZ_SW          = 32'b00000000000000000010000000100011;
`define RV_NOZ_FENCE       = 32'b00000000000000000000000000001111;
`define RV_NOZ_FENCE_I     = 32'b00000000000000000001000000001111;
`define RV_NOZ_ECALL       = 32'b00000000000000000000000001110011;
`define RV_NOZ_EBREAK      = 32'b00000000000100000000000001110011;
`define RV_NOZ_CSRRW       = 32'b00000000000000000001000001110011;
`define RV_NOZ_CSRRS       = 32'b00000000000000000010000001110011;
`define RV_NOZ_CSRRC       = 32'b00000000000000000011000001110011;
`define RV_NOZ_CSRRWI      = 32'b00000000000000000101000001110011;
`define RV_NOZ_CSRRSI      = 32'b00000000000000000110000001110011;
`define RV_NOZ_CSRRCI      = 32'b00000000000000000111000001110011;
`define RV_NOZ_SYSTEM      = 32'b00000000000000000000000001110011;
