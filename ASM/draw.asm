
### Draw

#Dawe a line
DrawLine:
# 5: color
# 6: start
# 7: end
# 8: step

addi $sp, $sp, 4
sw $4, ($sp) #store $4

or $4, $0, $6 # set $4 to start. $4 is the iterator
LOOP_Line:
bgt $4, $7, RET_Line
sb $5, 0($4)
add $4, $4, $8
beq $0, $0, LOOP_Line
RET_Line:
lw $4, ($sp)
subi $sp, $sp, 4 # restore $4
jr $31

DrawRec:
# 5: color
# 9: left-top
# 11: right-top
# 12: right-bottom
addi $sp, $sp, 4 # $4: length
sw $4, ($sp)
addi $sp, $sp, 4
sw $6, ($sp)
addi $sp, $sp, 4
sw $7, ($sp)
addi $sp, $sp, 4
sw $8, ($sp)
addi $sp, $sp, 4
sw $ra, ($sp)

#cal length
sub $4, $11, $9

# 5 OK
ori $8, $0, 1
or $6, $0, $9
# 8 OK
LOOP_REC:
bgt $6, $12, RET_REC
add $7, $6, $4
jal DrawLine
addi $6, $6, 40
beq $0, $0, LOOP_REC

RET_REC:
lw $ra, ($sp)
subi $sp, $sp, 4
lw $8, ($sp)
subi $sp, $sp, 4
lw $7, ($sp)
subi $sp, $sp, 4
lw $6, ($sp)
subi $sp, $sp, 4
lw $4, ($sp)
subi $sp, $sp, 4
jr $ra

DrawBorder:
# 5: color
# 9: left-top
# 10: left-bottom
# 11: right-top
# 12: right-bottom
addi $sp, $sp, 4
sw $6, ($sp)
addi $sp, $sp, 4
sw $7, ($sp)
addi $sp, $sp, 4
sw $8, ($sp)
addi $sp, $sp, 4
sw $ra, ($sp)

ori $8, $0, 1 #step
# 5 OK
# 8 OK
or $6, $0, $9
or $7, $0, $11
jal DrawLine
or $6, $0, $10
or $7, $0, $12
jal DrawLine
ori $8, $0, 40
or $6, $0, $9
or $7, $0, $10
jal DrawLine
or $6, $0, $11
or $7, $0, $12
jal DrawLine

lw $ra, ($sp)
subi $sp, $sp, 4
lw $8, ($sp)
subi $sp, $sp, 4
lw $7, ($sp)
subi $sp, $sp, 4
lw $6, ($sp)
subi $sp, $sp, 4
jr $ra

DrawBackground:
addi $sp, $sp, 4
sw $ra, ($sp)
addi $sp, $sp, 4
sw $5, ($sp)
addi $sp, $sp, 4
sw $9, ($sp)
addi $sp, $sp, 4
sw $10, ($sp)
addi $sp, $sp, 4
sw $11, ($sp)
addi $sp, $sp, 4
sw $12, ($sp)

ori $5, $0, 0x78
ori $9, $0, 1024
ori $10, $0, 2184
ori $11, $0, 1063
ori $12, $0, 2223
jal DrawRec

lw $12, ($sp)
subi $sp, $sp, 4
lw $11, ($sp)
subi $sp, $sp, 4
lw $10, ($sp)
subi $sp, $sp, 4
lw $9, ($sp)
subi $sp, $sp, 4
lw $5, ($sp)
subi $sp, $sp, 4
lw $ra, ($sp)
subi $sp, $sp, 4
jr $ra

DrawBOR:

# 5: color

addi $sp, $sp, 4
sw $ra, ($sp)
addi $sp, $sp, 4
sw $6, ($sp)
addi $sp, $sp, 4
sw $7, ($sp)
addi $sp, $sp, 4
sw $8, ($sp)

ori $8, $0, 40
ori $6, $0, 1152
ori $7, $0, 2072
jal DrawLine
ori $6, $0, 1159
ori $7, $0, 2079
jal DrawLine
ori $6, $0, 1160
ori $7, $0, 2080
jal DrawLine
ori $6, $0, 1167
ori $7, $0, 2087
jal DrawLine
ori $6, $0, 1168
ori $7, $0, 2088
jal DrawLine
ori $6, $0, 1175
ori $7, $0, 2095
jal DrawLine
ori $8, $0, 1
ori $6, $0, 1152
ori $7, $0, 1175
jal DrawLine
ori $6, $0, 1432
ori $7, $0, 1455
jal DrawLine
ori $6, $0, 1472
ori $7, $0, 1495
jal DrawLine
ori $6, $0, 1752
ori $7, $0, 1775
jal DrawLine
ori $6, $0, 1792
ori $7, $0, 1815
jal DrawLine
ori $6, $0, 2072
ori $7, $0, 2095
jal DrawLine

lw $8, ($sp)
subi $sp, $sp, 4
lw $7, ($sp)
subi $sp, $sp, 4
lw $6, ($sp)
subi $sp, $sp, 4
lw $ra, ($sp)
subi $sp, $sp, 4
jr $ra

## DrawSelect
# 5: color
# 6: select 0->8
DrawSelect:
addi $sp, $sp, 4
sw $ra, ($sp)
addi $sp, $sp, 4
sw $6, ($sp)
addi $sp, $sp, 4
sw $9, ($sp)
addi $sp, $sp, 4
sw $10, ($sp)
addi $sp, $sp, 4
sw $11, ($sp)
addi $sp, $sp, 4
sw $12, ($sp)

ori $9, $0, 1193
DrawSelect_CAL:
bgt $6, 2, DrawSelect_GT
mul $6, $6, 8
add $9, $9, $6
addi $11, $9, 5
addi $10, $9, 200
addi $12, $9, 205
jal DrawBorder
j DrawSelect_RET

DrawSelect_GT:
subi $6, $6, 3
addi $9, $9, 320
beq $0, $0, DrawSelect_CAL

DrawSelect_RET:
lw $12, ($sp)
subi $sp, $sp, 4
lw $11, ($sp)
subi $sp, $sp, 4
lw $10, ($sp)
subi $sp, $sp, 4
lw $9, ($sp)
subi $sp, $sp, 4
lw $6, ($sp)
subi $sp, $sp, 4
lw $ra, ($sp)
subi $sp, $sp, 4
jr $ra

DrawBlock:
# 5:color
# 6:block

addi $sp, $sp, 4
sw $ra, ($sp)
addi $sp, $sp, 4
sw $6, ($sp)
addi $sp, $sp, 4
sw $9, ($sp)
addi $sp, $sp, 4
sw $10, ($sp)
addi $sp, $sp, 4
sw $11, ($sp)
addi $sp, $sp, 4
sw $12, ($sp)

ori $9, $0, 1234
DrawBlock_CAL:
bgt $6, 2, DrawBlock_GT
mul $6, $6, 8
add $9, $9, $6
addi $11, $9, 3
addi $12, $9, 123
jal DrawRec
j DrawBlock_RET

DrawBlock_GT:
subi $6, $6, 3
addi $9, $9, 320
beq $0, $0, DrawBlock_CAL

DrawBlock_RET:
lw $12, ($sp)
subi $sp, $sp, 4
lw $11, ($sp)
subi $sp, $sp, 4
lw $10, ($sp)
subi $sp, $sp, 4
lw $9, ($sp)
subi $sp, $sp, 4
lw $6, ($sp)
subi $sp, $sp, 4
lw $ra, ($sp)
subi $sp, $sp, 4
jr $ra
