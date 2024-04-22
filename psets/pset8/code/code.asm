# main routine
.text
.globl main
main:
    # Preamble
    la $a0, data_a       # Load address of 'data_a' into $a0
    la $a1, data_b       # Load address of 'data_b' into $a1
    sw $ra, 0($sp)       # Save return address on stack
    addiu $sp, $sp, -4   # Adjust stack pointer

    # Call mist0
    jal mist0            # Jump and link to mist0

    # Restore and return from main
    lw $ra, 0($sp)       # Restore return address
    addiu $sp, $sp, 4    # Adjust stack pointer back
    jr $ra               # Return from main

# mist0 routine
.text
.globl mist0
mist0:
    # Preamble
    sw $s0, -4($sp)      # Save $s0 on stack
    addiu $sp, $sp, -4   # Adjust stack pointer

    # Body of mist0 (example operation)
    add $s0, $a0, $a1    # Example addition operation

    # Call mist1
    jal mist1            # Jump and link to mist1

    # Restore and conclude mist0
    lw $s0, 0($sp)       # Restore $s0
    addiu $sp, $sp, 4    # Adjust stack pointer back
    jr $ra               # Return from mist0

# mist1 routine
.text
.globl mist1
mist1:
    # Preamble
    sw $s1, -4($sp)      # Save $s1 on stack
    addiu $sp, $sp, -4   # Adjust stack pointer

    # Body of mist1 (example operation)
    sub $s1, $a0, $a1    # Example subtraction operation

    # Conclude mist1
    lw $s1, 0($sp)       # Restore $s1
    addiu $sp, $sp, 4    # Adjust stack pointer back
    jr $ra               # Return from mist1

.data
data_a: .word 10        # Example data
data_b: .word 20        # Example data
