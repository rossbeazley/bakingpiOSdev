.globl OKinit
OKinit:
push {r0,r1,lr}
mov r0,#16
mov r1,#1
bl SetGpioFunction
pop {r0,r1,pc}

.globl OKon
OKon:
push {r0,r1,lr}
mov r0,#16
mov r1,#0
bl SetGpio
pop {r0,r1,pc}

.globl OKoff
OKoff:
push {r0,r1,lr}
mov r0,#16
mov r1,#1
bl SetGpio
pop {r0,r1,pc}



