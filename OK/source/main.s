.section .init
.globl _start
_start:


ldr r0,=0x20200000

# set gpio 16 to output
mov r1,#1
lsl r1,#18
str r1,[r0,#4]
# end set gpio 16 to output

loop$: 

# write to gpio 16
mov r1,#1
lsl r1,#16
str r1,[r0,#40]
# end write to gpio 16


# sleep a bit
mov r2,#0x0F0000
wait1$:
sub r2,#1
cmp r2,#0
bne wait1$
# end sleep a bit

# reset to gpio 16
mov r1,#1
lsl r1,#16
str r1,[r0,#28]
# end reset to gpio 16

# sleep a bit
mov r2,#0x0F0000
wait2$:
sub r2,#1
cmp r2,#0
bne wait2$
# end sleep a bit


b loop$
