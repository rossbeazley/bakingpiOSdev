.globl GetGpioAddress /* this exports the symbol for the assembler */
GetGpioAddress:
ldr r0,=0x20200000
mov pc,lr /* return */



.globl SetGpioFunction
SetGpioFunction:
cmp r0,#53
cmpls r1,#7
movhi pc,lr

mov r2,r0

push {lr} /* going to do another branch so need to remember our return address */
bl GetGpioAddress

# GPIO controller address has been returned into r0
functionLoop$: # GPIO Controller Address + 4 × (GPIO Pin Number ÷ 10)
cmp r2,#9
subhi r2,#10
addhi r0,#4
bhi functionLoop$

add r2, r2,lsl #1
lsl r1,r2
str r1,[r0]
pop {pc}


.globl SetGpio
SetGpio:
pinNum .req r0  /* register alias */
pinVal .req r1

cmp pinNum,#53
movhi pc,lr
push {lr}
mov r2,pinNum
.unreq pinNum
pinNum .req r2
bl GetGpioAddress
gpioAddr .req r0

pinBank .req r3
lsr pinBank,pinNum,#5
lsl pinBank,#2
add gpioAddr,pinBank
.unreq pinBank


