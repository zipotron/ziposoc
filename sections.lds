
ENTRY( _start )

SECTIONS
{
  /*
   * ensure that start.S / _start is at 0x80000000,
   * where qemu's -kernel jumps.
   */
  . = 0x03000000;
  _leds = .;
  . = 0x80000000;

  .text : {
    *(.text .text.*)
    _start = .;
    PROVIDE(etext = .);
  }

  .data : {
    . = ALIGN(16);
    *(.sdata .sdata.*) /* do not need to distinguish this from .data */
    . = ALIGN(16);
    *(.data .data.*)
  }

  PROVIDE(end = .);
}
