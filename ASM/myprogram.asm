.data
# curX, 0x101 curX: .word 0
# curY, 0x102 curY: .word 0
# curStatus, 0x103 -> 0x10B: .space 36
# curPlayer, 0x10C: .word 1

.text
ori $sp, 0x200
j Main
.include "draw.asm"

Main:

ori $5, $0, 0x34
ori $9, $0, 1111
ori $10, $0, 2111
ori $11, $0, 1136
ori $12, $0, 2136
jal DrawBorder

ori $5, $0, 0x76
ori $9, $0, 1152
ori $11, $0, 1175
ori $12, $0, 2095
jal DrawRec

ori $5, $0, 0x2B
jal DrawBOR

ori $6, $0, 0 #curX
sw $6, 0x101
sw $6, 0x102
sw $6, 0x103
sw $6, 0x104
sw $6, 0x105
sw $6, 0x106
sw $6, 0x107
sw $6, 0x108
sw $6, 0x109
sw $6, 0x10A
sw $6, 0x10B

ori $14, $0, 1 #curPlayer
sw $14, 0x10C

ori $5, 0xFF
ori $6, $0, 0
jal DrawSelect
ori $6, $0, 1
jal DrawSelect
ori $6, $0, 2
jal DrawSelect
ori $6, $0, 3
jal DrawSelect
ori $6, $0, 4
jal DrawSelect
ori $6, $0, 5
jal DrawSelect
ori $6, $0, 6
jal DrawSelect
ori $6, $0, 7
jal DrawSelect
ori $6, $0, 8
jal DrawSelect

ori $6, $0, 0 #curSite

## Initial Complete

# BTN UP & DOWN
# BTN: 0->empty; 1->MID; 2->UP; 3->LEFT; 4->DOWN; 5->RIGHT
LOOP_BTN_FOR_1:
lw $15, 4096
beq $15, 0, LOOP_BTN_FOR_1
or $16, $0, $15 # $16 -> BTN
LOOP_BTN_FOR_0:
lw $15, 4096
bne $15, 0, LOOP_BTN_FOR_0

#DrawSelect(curX + curY * 3, "Black")
ori $5, $0, 0xFF
# 5, 6 OK
jal DrawSelect

# (curX, curY) = (newCurX, newCurY)
beq $16, 2, BTN_UP
beq $16, 3, BTN_LEFT
beq $16, 4, BTN_DOWN
beq $16, 5, BTN_RIGHT
beq $16, 1, BTN_MID

BTN_UP:
beq $6, 0, BTN_END
beq $6, 1, BTN_END
beq $6, 2, BTN_END
subi $6, $6, 3
beq $0, $0, BTN_END

BTN_LEFT:
beq $6, 0, BTN_END
beq $6, 3, BTN_END
beq $6, 6, BTN_END
subi $6, $6, 1
beq $0, $0, BTN_END

BTN_DOWN:
beq $6, 6, BTN_END
beq $6, 7, BTN_END
beq $6, 8, BTN_END
addi $6, $6, 3
beq $0, $0, BTN_END

BTN_RIGHT:
beq $6, 2, BTN_END
beq $6, 5, BTN_END
beq $6, 8, BTN_END
addi $6, $6, 1
beq $0, $0, BTN_END

BTN_END:
ori $5, $0, 0xB5
jal DrawSelect
beq $0, $0, LOOP_BTN_FOR_1

BTN_MID:
beq $0, $0, LOOP_BTN_FOR_1
