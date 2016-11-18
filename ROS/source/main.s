.section .init
.globl _start
_start:


b main

.section .text
main:
mov sp,#0x8000

/* enable output on pin 16 */
bl OKinit


ptrn .req r4
ldr ptrn,=pattern
ldr ptrn,[ptrn]
seq .req r5
mov seq,#0

loop$: 


/* creates a 000001 value,
   left shifts by the seq number to get something like 001000
   then and against the patern, we get a ZERO or if there is a 1 in the pattern at that point a NON-ZERO
*/
mov r1,#1
lsl r1,seq
and r1,ptrn


push {ptrn, seq}

bl OKon

# sleep a bit
mov r0, #200
bl WaitForMilliSeconds

bl OKoff

# sleep a bit
mov r0, #200
bl WaitForMilliSeconds


pop {ptrn,seq}

/* now increment sequence number modulo 32, ie 0-31 inclusive */
add seq, seq, #1
/* maybe we can use seq to do a ROR on the AND instead of LSL r1 by seq */
and seq, seq, #63

b loop$

.section .data
.align 2
pattern:
.int 0b11111111101010100010001000101010
