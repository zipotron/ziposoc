PREFIX = /opt/riscv32imc/bin/riscv32-unknown-elf-
FIRMWARE = main

PMEM_DEPTH=10
PMEM_WORDS=$(shell echo $$((1<<$(PMEM_DEPTH))))
PMEM_SIZE=$(shell echo $$((2<<$(PMEM_DEPTH))))

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
	cat main.bin /dev/zero | head -c $(PMEM_SIZE) | hexdump -v -e '/4 "%.8x\n"' > main.mem

flash_array.vh: main.mem
	awk '{ printf("flash_array[%d]=32%ch%s;\n",n,39,$$1);n++; }' < main.mem > flash_array.vh

main.disasm: main.elf
	$(PREFIX)objdump -s -m $(ARCH) -d main.elf > main.disasm

sint: ziposoc.bin

#ziposoc_tb.vcd: ziposoc.v ziposoc_tb.v
#	iverilog -o ziposoc_tb.out ziposoc.v ziposoc_tb.v
#	./ziposoc_tb.out
#	gtkwave ziposoc_tb.vcd ziposoc_tb.gtkw &

ziposoc.bin: ziposoc.v ziposoc.pcf
	#yosys -p "synth_ice40 -blif ziposoc.blif" ziposoc.v
	yosys -p 'synth_ice40 -top ziposoc -json ziposoc.json' ziposoc.v zipocpu.v data_bus.v flash.v ram.v instr_decompress.v

	#arachne-pnr -d 8k -P tq144:4k -p ziposoc.pcf ziposoc.blif -o ziposoc.txt
	nextpnr-ice40 --hx8k --package tq144:4k --json ziposoc.json --pcf ziposoc.pcf --asc ziposoc.asc

	#icepack ziposoc.txt ziposoc.bin
	icepack ziposoc.asc ziposoc.bin

flash:
	iceprog -d i:0x0403:0x6010:0 ziposoc.bin

clean:
	rm -f $(TARGETS) *.o *.elf *.mem *.disasm *.hex *.bin *.asc *.json *.out *.vcd *~
