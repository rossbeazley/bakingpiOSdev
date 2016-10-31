.globl WaitForSeconds /* this exports the symbol for the assembler */
WaitForSeconds:
pSeconds .req r0
cTimerBase .req r4
lStartTime .req r5
lTimeDiscard .req r8
lWaitMicroSeconds .req r6
cMicroSecondsInASecond .req r7
lCurrentTime .req r9

ldr cTimerBase,=0x20003000 /* timer base address, TODO convert to constant */
ldr cMicroSecondsInASecond,=0x1000000 /* timer base address, TODO convert to constant */

/*
convert wait time from seconds to microseconds 
Capture start time,
whilst
current time - start time > wait time

return
*/

mul lWaitMicroSeconds,pSeconds,cMicroSecondsInASecond
ldrd lStartTime,lTimeDiscard,[cTimerBase,#4]

ldrd lCurrentTime,lTimeDiscard,[cTimerBase,#4]

sub r10, lCurrentTime, lStartTime

/* check if r10 > wait time */ 

.unreq pSeconds
.unreq cTimerBase
.unreq lStartTime
.unreq lTimeDiscard
.unreq lWaitMicroSeconds

mov pc,lr /* return */
