.data
.globl printboard
openbracket: .asciiz "|"
closebracket: .asciiz " |"
spacedbracket: .asciiz " | "
line : .asciiz "-----------------------------\n"
padding: .asciiz "|      |      |      |      |\n"
nextline: .asciiz "\n"
three : .asciiz "    "
two : .asciiz "   "
one : .asciiz "  "
space: .asciiz " "
clear: .asciiz "\x1b[2J"   # ESC[2J clears, ESC[H moves cursor to top-left
#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#
.text
digit:
li t0 0
 while :
 beq a1 zero exit 
 li t1 10
 div a1 a1 t1
 addi t0 t0 1 
 j while

 exit : 
 mv a1 t0
 jr ra 

check:
    mv t4 ra
    jal digit 
    mv ra t4
    beq a1 zero print3space
    li a0 1
    beq a1 a0 print3space
    li a0 2
    beq a1 a0 print2space
    li a0 3
    beq a1 a0 print1space
    li a0 4
    beq a1 a0 printspace
    printnum:
    li a0 1
    mv a1 t3
    ecall
    jr ra

print3space:
    li a0 4         
    la a1 three    
    ecall 
    j printnum
print2space:
    li a0 4         
    la a1 two    
    ecall 
    j printnum
print1space:
    li a0 4         
    la a1 one    
    ecall 
    j printnum    
printspace:
    li a0 4         
    la a1 space    
    ecall 
    j printnum   

printline:
    li a0 4         
    la a1 line      
    ecall 
    jr ra
printpadding:
    li a0 4         
    la a1 padding     
    ecall 
    jr ra
printnextline:
    li a0 4         
    la a1 nextline    
    ecall 
    jr ra
printopenbracket:
    li a0 4         
    la a1 openbracket    
    ecall 
    jr ra
printclosedbracket:
    li a0 4         
    la a1 closebracket   
    ecall 
    jr ra
printspacedbracket:
    li a0 4         
    la a1 spacedbracket   
    ecall 
    jr ra

printboard:
addi sp sp -8
sw s1 0(sp)
sw s2 4(sp)
mv s1 a0
mv s2 ra
li t5 4
jal printline
loop1:
 beq t5 zero exit1
 li t6 4
 jal printpadding
 jal printopenbracket
 loop:
 beq t6 zero exit2
 lhu a1 0(s1)
 addi s1 s1 2
 mv t3 a1
 jal check
 jal printclosedbracket
 addi t6 t6 -1
 j loop
 exit2: 
 jal printnextline
 jal printpadding
 jal printline
 addi t5 t5 -1
 j loop1
 exit1:
 mv ra s2
 lw s1 0(sp)
 lw s2 4(sp)
 addi sp sp 8
    jr ra



