.text
.globl move_left

.import "move_one.s"
#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#

move_left:
    addi sp sp -12
    sw a0 0(sp)
    sw a1 4(sp)
    sw ra 8(sp)

    move_left_loop:
    lw a0 0(sp)
    lw a1 4(sp)
    jal move_one
    beqz a0 move_left_return 
    j move_left_loop

    move_left_return:
    lw ra 8(sp)
    addi sp sp 12
    jr ra
