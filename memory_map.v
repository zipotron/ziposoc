/* CSR */
`define CSR_RANGE 31:6
/* 0 .. 0x40  64bytes*/
`define MSTATUS 32'h00000000 //4 bytes Machine status
`define MCAUSE 32'h00000004 //4 bytes interruption or exception cause
`define MTIME 32'h00000008 //8 bytes
`define MTIMECMP 32'h00000010 //8 bytes
//`define MIP 32'h00000024 //4 bytes Pending interrupts
`define MTVEC 32'h00000018 //4 bytes base address of interrupt handler (Direct)
`define MEPC 32'h0000001C //4 bytes Return adress after interrupt
`define MSCRATCH 32'h00000020 //4 bytes Can be used a Stack pointer for interruption processing

/* data section b'1000000*/
`define DATA_RANGE 31:13
`define DATA_TOKEN 6:12
/* 0x40 .. 0x1000*/
`define RAM_INIT 32'h00000040
`define RAM_END 32'h00001000
`define INITIAL_PC 32'h00000040
`define INITIAL_SP 32'h00000800

/* mapped IO section b'10000000000000*/
`define IO_RANGE 31:15
`define IO_TOKEN 13:14
/* 0x2000 */
`define LEDS 32'h00002000
