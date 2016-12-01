.globl WaitForSeconds /* this exports the symbol for the assembler */
.globl WaitForMilliSeconds /* this exports the symbol for the assembler */
.globl slightPause

slightPause:
    push {r0,lr}
    mov r0, #200
    bl WaitForMilliSeconds
    pop {r0,pc}

WaitForSeconds:

    ldr r2,=1000000 /* timer base address, TODO convert to constant, 0xF4240 */
    mul r1,r0,r2

    push {lr}
    bl WaitForMicroseconds
    pop {pc}

WaitForMilliSeconds:

    ldr r2,=1000 /* timer base address, TODO convert to constant */
    mul r1,r0,r2

    push {lr}
    bl WaitForMicroseconds
    pop {pc}



WaitForMicroseconds:
    lWaitMicroSeconds .req r1

    cTimerBase .req r4
    lStartTime .req r6
    lTimeDiscard .req r7
    lCurrentTime .req r10
    lCurrentTimeDiscard .req r11
    lTmp .req r12

    ldr cTimerBase,=0x20003000 /* timer base address, TODO convert to constant */

    /* capture start time */
    ldrd lStartTime,lTimeDiscard,[cTimerBase,#4]

    while$1:
    ldrd lCurrentTime,lCurrentTimeDiscard,[cTimerBase,#4]

    sub lTmp, lCurrentTime, lStartTime
    /* check if lTmp >  wait time */
    cmp lTmp, lWaitMicroSeconds
    bls while$1 /* if lTmp is bigger than wait time, we branch(loop) is negative */

    .unreq cTimerBase
    .unreq lStartTime
    .unreq lTimeDiscard
    .unreq lWaitMicroSeconds
    .unreq lCurrentTime
    .unreq lTmp


    mov pc,lr /* return */

