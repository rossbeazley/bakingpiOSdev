.globl WaitForSeconds /* this exports the symbol for the assembler */

WaitForSeconds:

pSeconds .req r0
cTimerBase .req r4
lStartTime .req r6
lTimeDiscard .req r7
lWaitMicroSeconds .req r8
cMicroSecondsInASecond .req r9
lCurrentTime .req r10
lCurrentTimeDiscard .req r11
lTmp .req r12

ldr cTimerBase,=0x20003000 /* timer base address, TODO convert to constant */
ldr cMicroSecondsInASecond,=0xF4240 /* timer base address, TODO convert to constant */

/* capture start time */
mul lWaitMicroSeconds,pSeconds,cMicroSecondsInASecond
ldrd lStartTime,lTimeDiscard,[cTimerBase,#4]

while$1:
ldrd lCurrentTime,lCurrentTimeDiscard,[cTimerBase,#4]

sub lTmp, lCurrentTime, lStartTime
/* check if lTmp >  wait time */ 
cmp lTmp, lWaitMicroSeconds
bls while$1 /* if lTmp is bigger than wait time, we branch(loop) is negative */

.unreq pSeconds
.unreq cTimerBase
.unreq lStartTime
.unreq lTimeDiscard
.unreq lWaitMicroSeconds
.unreq cMicroSecondsInASecond
.unreq lCurrentTime
.unreq lTmp


mov pc,lr /* return */
