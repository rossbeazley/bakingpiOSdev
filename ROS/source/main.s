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

bl OKblink


b loop$
