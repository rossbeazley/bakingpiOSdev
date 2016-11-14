.globl GetMailboxBase
GetMailboxBase:
ldr r0,=0x2000B880
mov pc,lr


/* r0 contains the mailbox channel
   returns the message in r0  */
.globl MailboxRead
MailboxRead:
cmp r0,#15
movhi pc,lr

channel .req r1
mov channel,r0
push {lr}
bl GetMailboxBase
mailbox .req r0

rightmail$:

/**Wait until 30th bit is 0*/
wait2$:
status .req r2
ldr status,[mailbox,#0x18]
tst status,#0x40000000
.unreq status
bne wait2$

mail .req r2
ldr mail,[mailbox,#0]

/** this will branch back to rightmail if this isnt a message for us*/
nchan .req r3
and inchan,mail,#0b1111
teq inchan,channel
.unreq inchan
bne rightmail$
.unreq mailbox
.unreq channel

/** return the contents of the message - ie the top 28 bits */
and r0,mail,#0xfffffff0
.unreq mail
pop {pc}


/* r0 contains a message to write (only the top 28 bits)
   r1 contains the mailbox channel */
.globl MailboxWrite
MailboxWrite: 
tst r0,#0b1111
movne pc,lr
cmp r1,#15
movhi pc,lr

cannel .req r1
value .req r2
mov value,r0
push {lr}
bl GetMailboxBase
mailbox .req r0

/** wait for top bit of status to be 0 */
wait1$:
status .req r3
ldr status,[mailbox,#0x18]
tatus,#0x80000000
.unreq status
bne wait1$

/** combine channel and message together and write to mailbox */
add value,channel
.unreq channel
str value,[mailbox,#0x20]
.unreq value
.unreq mailbox

/**return*/
pop {pc}

