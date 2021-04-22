.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
#define A #2
#define B #4
#define C #3

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	start_data: .asciz "kernel start\n"
	finish_data: .asciz "result!\n"

.section .text
__kernel_reset__:
    mov r0, #0
    ldr r0, =start_data
    bl dbgput_line
    

	mov r0, A
	mov r1, B
	ADD r0, r0, r1
	mov r1, #2
	SDIV r0, r0, r1
	mov r1, #1
	mov r2, C

	.fact:
		MUL r1, r2
		SUBS r2, #1
		bne .fact
	ADD r0, r0, r1
	mov r1, #0
	mov r2, #0

	bl dbgput_num
	ldr r0, =finish_data
	bl dbgput_line
	
	end:
	b end
