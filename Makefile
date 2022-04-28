PIN_DEF ?= ulx3s_v20.lpf
DEVICE ?= 85k

PREFIX = /opt/riscv32imc/bin/riscv32-unknown-elf-
FIRMWARE = main

PMEM_DEPTH=10
CSR_SIZE=8
PMEM_SIZE=$(shell echo $$(((2<<$(PMEM_DEPTH))-$(CSR_SIZE))))

.PHONY: all clean

TARGETS=main.disasm main.mem flash_array.vh

all: $(TARGETS)

main.elf: sections.lds start.s firmware.c
	$(PREFIX)gcc -march=rv32imc -Wl,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib -o $(FIRMWARE).elf start.s firmware.c
	
main.hex: main.elf
	$(PREFIX)objcopy -j .text -j .data -O ihex main.elf main.hex

main.bin: main.elf
	$(PREFIX)objcopy -j .text -j .data -O binary main.elf main.bin

main.mem: main.bin
	cat main.bin /dev/zero | head -c $(PMEM_SIZE) | hexdump -v -e '/8 "%.16x\n"' > main.mem

flash_array.vh: main.mem
	awk '{ printf("ram_array[%d]=64%ch%s;\n",n+$(CSR_SIZE),39,$$1);n=n+1; }' < main.mem > flash_array.vh

main.disasm: main.elf
	$(PREFIX)objdump -s -m $(ARCH) -d main.elf > main.disasm

sint: ziposoc.bit

ziposoc.bit: ziposoc.v

	yosys -p 'synth_ecp5 -top ziposoc -json ziposoc.json' ziposoc.v zipocpu.v data_bus.v ram.v instr_decompress.v

	nextpnr-ecp5 --${DEVICE} --package CABGA381 --freq 25 --json ziposoc.json --lpf ulx3s_v20.lpf --textcfg ziposoc.config

	ecppack ziposoc.config --compress ziposoc.bit

flash:
	fujprog ziposoc.bit


sim:
	iverilog -o data_bus_tb.out memory_map.v data_bus.v ram.v data_bus_tb.v
	./data_bus_tb.out &
	gtkwave data_bus_tb.vcd data_bus_tb.gtkw

diagram:
	yosys -p 'prep -top ziposoc; write_json ziposoc.json' ziposoc.v zipocpu.v data_bus.v ram.v instr_decompress.v
	
schematic:
	yosys -p 'prep -top ziposoc -flatten; write_json ziposoc.json' ziposoc.v zipocpu.v data_bus.v ram.v instr_decompress.v
	
clean:
	rm -f $(TARGETS) *.o *.elf *.mem *.disasm *.hex *.bin *.bit *.json *.config *.out *.vcd *~
