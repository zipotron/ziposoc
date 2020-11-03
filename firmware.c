/*
 *  Ziposoc - A simple example SoC using RV32
 *
 *  Copyright (C) 2020  Carlos Dominguez <zipotron@disroot.org>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include <stdint.h>
#include <stdbool.h>

extern uint32_t _leds;

//#define reg_leds (*(volatile uint32_t*)0x03000000)

void main()
{
	volatile uint32_t *reg_leds = (volatile uint32_t *)&_leds;
	while (1)
	{
		for(int c=0;c<10000;c++)
		*reg_leds = 65;
		for(int c=0;c<10000;c++)
		*reg_leds = 129;
	}
}
