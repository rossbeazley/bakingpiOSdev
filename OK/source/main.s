.section .init
.globl _start
_start:


b main

.section .text
main:
mov sp,#0x8000

/* enable output on pin 16 */
pinNum .req r0
pinFunc .req r1
mov pinNum,#16
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

loop$: 

/* turn pin 16 on */
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#0
bl SetGpio
.unreq pinNum
.unreq pinVal

# sleep a bit
mov r2,#0x0F0000
wait1$:
sub r2,#1
cmp r2,#0
bne wait1$
# end sleep a bit


/* turn pin 16 off */
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#1
bl SetGpio
.unreq pinNum
.unreq pinVal



# sleep a bit
mov r2,#0x0F0000
wait2$:
sub r2,#1
cmp r2,#0
bne wait2$
# end sleep a bit


b loop$
