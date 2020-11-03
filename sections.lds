
ENTRY( _start )

SECTIONS
{
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
  . = 0x03000000;
  _leds = .;
  PROVIDE(end = .);
}
