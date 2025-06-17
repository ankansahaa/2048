.text
.globl merge

#
#	a0 buffer address
#	a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in a0 and the
#          total base score of the merges in a1.

merge:
    addi a1 a1 -1
    li t5 0
    li t6 0

    merge_loop:
    beqz a1 merge_loop_return
    lw t1 0(a0)
    lhu t1 0(t1)
    lw t2 4(a0)
    lhu t2 0(t2)
    bnez t2 merge_part
    addi a0 a0 4
    addi a1 a1 -1
    j merge_loop

    merge_part:
    addi a0 a0 4
    addi a1 a1 -1
    bne t1 t2 merge_loop
    lw t0 -4(a0)
    slli t2 t2 1

    addi t5 t5 1
    add t6 t6 t2 

    sh t2 0(t0)
    lw t0 0(a0)
    sh zero 0(t0)
    j merge_loop

    merge_loop_return:
    mv a0 t5
    mv a1 t6
    jr ra
