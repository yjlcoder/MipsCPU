.data
curX: .word 0
curY: .word 0
curStatus: .space 36
curPlayer: .word 1

.text

#Draw
nop

LOOP:

#judge if complete
nop

#if complete
beq $31, 1, COMPLETE

#else

#wait for the key, key -> $10
# no -> 0, left is 1, right is 2, up is 3, down is 4, mid is 5
WAIT:
beq $10, 0, WAIT
beq $10, 1, LEFT
beq $10, 2, RIGHT
beq $10, 3, UP
beq $10, 4, DOWN
beq $10, 5, MID

LEFT:
lw $1, curY
beq $1, 0, LOOP
sub $1, $1, 1
sw $1, curY
j LOOP

RIGHT:
lw $1, curY
beq $1, 2, LOOP
add $1, $1, 1
sw $1, curY
j LOOP

UP:
lw $1, curX
beq $1, 0, LOOP
sub $1, $1, 1
sw $1, curX
j LOOP

DOWN:
lw $1, curX
beq $1, 2, LOOP
add $1, $1, 1
sw $1, curX
j LOOP

MID:
lw $1, curX
lw $2, curY
lw $3, curPlayer
mul $4, $1, 3
add $4, $4, $2 #  $4,index
lw $5, curStatus($4)
bne $5, 0, LOOP 
sw $3, curStatus($4)
beq $3, 1, SIGN2
sw $3, 1
j LOOP
SIGN2:
sw $3, 2
j LOOP


COMPLETE:
ori $1, $0, 0
sw $1, curStatus+0
sw $1, curStatus+1
sw $1, curStatus+2
sw $1, curStatus+3
sw $1, curStatus+4
sw $1, curStatus+5
sw $1, curStatus+6
sw $1, curStatus+7
sw $1, curStatus+8
j LOOP
