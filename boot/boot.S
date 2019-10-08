#include "boot.h"

.code16
.globl start
start:
	cli
	# Set segments on Zero
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %ss
	mov %dl, init_dl // save boot drive
init_dl: .byte 0

	CLEAN
	RESET_CURSOR
	LOAD_NSECTOR $1

	lgdt gdtdesc

	mov %cr0, %eax
	mov $0x1, %eax
	mov %eax, %cr0

	ljmp $0x08, $start32

.code32
start32:
	mov $0x10, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %ss

	mov $0x8000, %esp // move the esp to a any place
	call boot_main
halt:
	hlt
	jmp halt

.p2align 2
gdt:
	.quad 0x0000000000000000 // null descriptor
	.quad 0x00cf9a000000ffff // code descriptor type=execute/read
	.quad 0x00cf92000000ffff // data descriptor type=read/write
gdtdesc:
	.word (gdtdesc - gdt - 1)
	.long gdt
