.text
.globl place

# 	a0 board address
# 	a1 board length
#	a2 field number to place into
#	a3 number to place
#
#	a0 == 0 iff place succesfull else 1
#

place:
    slli t0 a2 1
    add a0 a0 t0
    lhu t1 0(a0)
    beq t1 zero placed_successfully

    placed_unsuccessfully:
    li a0 1
    jr ra
    
    placed_successfully: 
    sh a3 0(a0)
	li a0 0
    jr ra
