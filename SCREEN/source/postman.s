.globl GetMailboxBase
GetMailboxBase:
ldr r0,=0x2000B880
mov pc,lr


/* r0 contains the mailbox channel
   returns the message in r0  */
.globl MailboxRead
MailboxRead:
/*
 mov r0 to r4 (mailbox)
 loop: 
 while Status bit 30 is not 0 loop
 load Read into r0
 if mailbox not matches r0 loop
 return Read (r0) 
*/


/* r0 contains a message to write (only the top 28 bits)
   r1 contains the mailbox channel */
.globl MailboxWrite
MailboxWrite:
/*
loop:
 while Status bit 32 is not 0 loop
 munge r0 and r1
 write to Write
*/


