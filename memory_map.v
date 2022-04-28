/* CSR */
`define CSR_RANGE 63:5
/* 0 .. 0x40  64bytes*/
`define MSTATUS 64'h0000000000000000 //4 bytes Machine status
`define MCAUSE 64'h0000000000000004 //4 bytes interruption or exception cause
`define MTIME 64'h0000000000000008 //8 bytes
`define MTIMECMP 64'h0000000000000010 //8 bytes
//`define MIP 64'h0000000000000024 //4 bytes Pending interrupts
`define MTVEC 64'h0000000000000018 //4 bytes base address of interrupt handler (Direct)
`define MEPC 64'h000000000000001C //4 bytes Return adress after interrupt
`define MSCRATCH 64'h0000000000000020 //4 bytes Can be used a Stack pointer for interruption processing

/* data section b'1000000*/
`define DATA_RANGE 63:12
`define DATA_TOKEN 11:6//6:11
/* 0x40 .. 0x1000*/
`define RAM_INIT 64'h0000000000000040
`define INITIAL_PC 64'h0000000000000040
`define INITIAL_SP 64'h0000000000000800

/* mapped IO section b'1000000000000*/
`define IO_RANGE 63:14
`define IO_TOKEN 13:12//12:13
/* 0x1000 */
`define IO_INIT 64'h0000000000001000
`define LEDS 64'h0000000000001000

`define MEM_END 64'h0000000000001080
