.text
.globl check_victory


#
#	a0 board address
#	a1 board length
#
#	a0 == 1 iff 2048 found
#

check_victory:
    li t1 2048
    slli t3 a1 1 
    add t2 a0 t3
    loop:
    beq a0 t2 not_victory
    lhu t0 0(a0)
    beq t0 t1 victory
    addi a0 a0 2
    j loop
    not_victory:
    li a0 0
    jr ra
    victory:
    li a0 1
    jr ra