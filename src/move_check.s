.text
.globl move_check
#
#	a0 buffer address
#	a1 buffer length
#
#   a0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
	li t0 0
	addi a1 a1 -1

	move_check_loop:
	beq t0 a1 not_possible
	lw t1 0(a0)
	lhu t1 0(t1)
	lw t2 4(a0)
	lhu t2 0(t2)
	beqz t1 check_right
	beq t1 t2 possible
	addi t0 t0 1
	addi a0 a0 4
	j move_check_loop

	possible:
	li a0 1
	jr ra

	not_possible:
	li a0 0
	jr ra

check_right:
	addi t0 t0 1
	addi a0 a0 4
	beqz t2 move_check_loop
	j possible