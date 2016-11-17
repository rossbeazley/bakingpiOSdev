.section .init
.globl _start
_start:


b main

.section .text
main:
mov sp,#0x8000

loop:
bl OKon
mov r0,#1
bl WaitForSeconds
bl OKoff
mov r0,#1
bl WaitForSeconds
b loop
