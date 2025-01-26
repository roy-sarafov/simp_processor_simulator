
    add $s0, $zero, $zero, $zero, 0, 0      #
row:
    add $s1, $zero, $zero, $zero, 0, 0      #
col:
    add $s2, $zero, $zero, $zero, 0, 0      #
    add $v0, $zero, $zero, $zero, 0, 0      #
elem:
    sll $t0, $s0, $imm2, $zero, 0, 2        #
    add $t0, $t0, $s2, $zero, 0, 0          #
    lw $t0, $t0, $imm1, $zero, 0x100, 0     #

    sll $t1, $s2, $imm2, $zero, 0, 2        #
    add $t1, $t1, $s1, $zero, 0, 0          #
    lw $t1, $t1, $imm1, $zero, 0x110, 0     #

    mac $v0, $t0, $t1, $v0, 0, 0            #

    add $s2, $s2, $zero, $imm1, 1, 0        #
    blt $zero, $s2, $imm1, $imm2, 4, elem   #

    sll $t0, $s0, $imm2, $zero, 0, 2        #
    add $t0, $t0, $s1, $zero, 0, 0          #
    sw $zero, $imm1, $t0, $v0, 0x120, 0     #

    add $s1, $s1, $zero, $imm1, 1, 0        #
    blt $zero, $s1, $imm1, $imm2, 4, col    #

    add $s0, $s0, $zero, $imm1, 1, 0        #
    blt $zero, $s0, $imm1, $imm2, 4, row    #

    halt $zero, $zero, $zero, $zero 0, 0    #

    .word 0x100 1
    .word 0x101 1
    .word 0x102 1
    .word 0x103 1
    .word 0x104 1
    .word 0x105 1
    .word 0x106 1
    .word 0x107 1
    .word 0x108 1
    .word 0x109 1
    .word 0x10A 1
    .word 0x10B 1
    .word 0x10C 1
    .word 0x10D 1
    .word 0x10E 1
    .word 0x10F 1

    .word 0x110 1
    .word 0x111 2
    .word 0x112 3
    .word 0x113 4
    .word 0x114 5
    .word 0x115 6
    .word 0x116 7
    .word 0x117 8
    .word 0x118 9
    .word 0x119 10
    .word 0x11A 11
    .word 0x11B 12
    .word 0x11C 13
    .word 0x11D 14
    .word 0x11E 15
    .word 0x11F 16
