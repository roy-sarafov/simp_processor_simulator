add $sp, $zero, $imm1, $zero, 900, 0        # Initialize stack pointer
add $t0, $zero, $zero, $zero, 0, 0         # $t0 = sector index (0)
add $s1, $zero, $imm1, $zero, 0, 0  # Load buffer address for memory
add $t1, $zero, $imm1, $zero, 1, 0         # $t1 = sector index for writing (starts at 1)
load_loop:
    out $zero, $zero, $imm2, $t0, 0, 15    # Set disksector = $t0
    out $zero, $zero, $imm2, $s1, 0, 16    # Set diskbuffer = $s1
    out $zero, $zero, $imm2, $imm1, 1, 14  # diskcmd = 1 (read)
wait_read:
    in $s2, $zero, $imm2, $zero, 0, 17     # Load diskstatus
    bne $zero, $s2, $zero, $imm1, wait_read, 0       # Wait until diskstatus == 0
    add $s1, $s1, $imm1, $zero, 512, 0    # Increment memory address for next sector
    add $t0, $t0, $imm1, $zero, 1, 0      # Increment sector index
    add $a0, $zero, $imm1, $zero, 8, 0    # $a0 = 8 (total sectors to read)
    beq $zero, $t0, $a0, $imm1, init, 0 # If $t0 == 8, go to store_loop
    beq $zero, $zero, $zero, $imm1, load_loop, 0 # Repeat load_loop
init:
    add $s1, $zero, $imm1, $zero, 0, 0  # Load buffer address for memory (in the first time of store loop it will be 1000)
store_loop:
    out $zero, $zero, $imm1, $t1, 15, 0   # Set disksector = $t1
    out $zero, $zero, $imm1, $s1, 16, 0   # Set diskbuffer = $s1
    out $zero, $zero, $imm2, $imm1, 2, 14 # diskcmd = 2 (write)
wait_write:
    in $s2, $zero, $imm2, $zero, 0, 17    # Load diskstatus
    bne $zero, $s2, $zero, $imm1, wait_write, 0     # Wait until diskstatus == 0
    add $s1, $s1, $imm1, $zero, 512, 0   # Increment memory address
    add $t1, $t1, $imm1, $zero, 1, 0      # Increment write sector index
    add $a1, $zero, $imm1, $zero, 9, 0    # $a1 = 9
    beq $zero, $t1, $a1, $imm1, end, 0    # If $t1 == 9, end
    beq $zero, $zero, $zero, $imm1, store_loop, 0 # Repeat store_loop
end:
    add $sp, $zero, $imm1, $zero, 900, 0  # Restore stack pointer
    halt $zero, $zero, $zero, $zero, 0, 0  # Halt program