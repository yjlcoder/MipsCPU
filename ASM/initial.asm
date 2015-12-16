.text

INITIAL_ALL:
ori $4, $0, 0
ori $29, $0, 1024
LOOP_ALL:
bgt $29, 2223, INITIAL_X1
sb $4, 0($29)
add $29, $29, 1
beq $0, $0, LOOP_ALL

INITIAL_X1:
ori $4, $0, 0
add $4, $4, 0x76
ori $29, $0, 1111
LOOP_X1:
bgt $29, 1136, INITIAL_Y1
sb $4, 0($29)
add $29, $29, 1
beq $0, $0, LOOP_X1

INITIAL_Y1:
ori $29, $0, 1151
LOOP_Y1:
bgt $29, 2111, INITIAL_X2
sb $4, 0($29)
add $29, $29, 40
beq $0, $0, LOOP_Y1

INITIAL_X2:
ori $29, $0, 2112
LOOP_X2:
bgt $29, 2136 INITIAL_Y2
sb $4, 0($29)
add $29, $29, 1
beq $0, $0, LOOP_X2

INITIAL_Y2:
ori $29, $0, 1176
LOOP_Y2:
bgt $29, 2096, END
sb $4, 0($29)
add $29, $29, 40
beq $0, $0, LOOP_Y2

END:
beq $0, $0, END
