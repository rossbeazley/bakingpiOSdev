.globl GetGpioAddress
GetGpioAddress:
ldr r0,=0x20200000
mov pc,lr

.globl SetGpioFunction
SetGpioFunction:
cmp r0,#53
cmpls r1,#7
movhi pc,lr

mov r2,r0

push {lr}
bl GetGpioAddress

# GPIO controller address has been returned into r0
functionLoop$: # GPIO Controller Address + 4 × (GPIO Pin Number ÷ 10)
cmp r2,#9
subhi r2,#10
addhi r0,#4
bhi functionLoop$


