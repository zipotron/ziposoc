PREFIX = /opt/riscv32imc/bin/riscv32-unknown-elf-
FIRMWARE = main

PMEM_DEPTH=10
PMEM_WORDS=$(shell echo $$((1<<$(PMEM_DEPTH))))
PMEM_SIZE=$(shell echo $$((2<<$(PMEM_DEPTH))))

.PHONY: all clean

TARGETS=main.disasm main.mem flash_array.v

all: $(TARGETS)

main.elf: sections.lds start.s firmware.c
	$(PREFIX)gcc -march=rv32imc -Wl,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib -o $(FIRMWARE).elf start.s firmware.c
	
main.hex: main.elf
	$(PREFIX)objcopy -j .text -j .data -O ihex main.elf main.hex

main.bin: main.elf
	$(PREFIX)objcopy -j .text -j .data -O binary main.elf main.bin

main.mem: main.bin
	cat main.bin /dev/zero | head -c $(PMEM_SIZE) | hexdump -v -e '/4 "%.8x\n"' > main.mem

flash_array.v: main.mem
	awk '{ printf("flash_array[%d]=32%ch%s;\n",n,39,$$1);n++; }' < main.mem > flash_array.v

main.disasm: main.elf
	$(PREFIX)objdump -s -m $(ARCH) -d main.elf > main.disasm

clean:
	rm -f $(TARGETS) *.o *.elf *.mem *.disasm *.hex *.bin
