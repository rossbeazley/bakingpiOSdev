.section .init
.globl _start
_start:


b main

.section .text
main:
mov sp,#0x8000

bl OKinit



/* setup the screen.
*/
	mov r0,#1024
	mov r1,#768
	mov r2,#16
	bl InitialiseFrameBuffer

bl OKblink

/* NEW
* Check for a failed frame buffer.
*/
	teq r0,#0
	bne noError$
		
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

	mov r0,#16
	mov r1,#0
	bl SetGpio

	error$:
		bl OKon
		bl slightPause
		bl slightPause
		bl slightPause
		bl OKoff
		bl slightPause

		b error$

	noError$:

	fbInfoAddr .req r4
	mov fbInfoAddr,r0


render$:
	bl OKinit
	fbAddr .req r3
	ldr fbAddr,[fbInfoAddr,#32]

	colour .req r0
	y .req r1
	mov y,#768
	drawRow$:
		x .req r2
		mov x,#1024
		drawPixel$:
			strh colour,[fbAddr]
			add fbAddr,#2
			sub x,#1
			teq x,#0
			bne drawPixel$

		sub y,#1
		add colour,#1
		teq y,#0
		bne drawRow$

	b render$

	.unreq fbAddr
	.unreq fbInfoAddr



