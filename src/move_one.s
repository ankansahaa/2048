.data
.import "move_check.s"
.text
.globl move_one

#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	a0 1 iff something changed else 0

move_one:
	addi sp sp -12
	sw ra 0(sp)
	sw a0 4(sp)
	sw a1 8(sp)
	jal move_check
	li t0 0
	beqz a0 move_one_return

	lw a0 4(sp)
	lw a1 8(sp)
	addi a1 a1 -1

	move_one_loop:
	beqz a1 move_one_return
	lw t1 0(a0)
	lhu t1 0(t1)
	lw t2 4(a0)
	lhu t2 0(t2)
	beqz t1 shiftleft_one
	addi a0 a0 4
	addi a1 a1 -1
	j move_one_loop

	shiftleft_one:
	addi a0 a0 4
	addi a1 a1 -1
	beq t1 t2 move_one_loop
	lw t3 -4(a0)
	sh t2 0(t3)
	lw t3 0(a0)
	sh zero 0(t3)
	li t0 1
	j move_one_loop

	move_one_return:
	lw ra 0(sp)
	addi sp sp 12
	mv a0 t0
	jr ra
