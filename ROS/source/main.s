.section .init
.globl _start
_start:


b main

.section .text
main:
mov sp,#0x8000

bl OKinit

loop$:

bl OKon
bl slightPause
bl OKoff
bl slightPause
b loop$



.section .data
.align 2
pattern:
.int 0b11111111101010100010001000101010
