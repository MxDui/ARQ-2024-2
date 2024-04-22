.data
print_str: .asciiz "The binomial coefficient is: \n"

.text
.globl main

main:
    li $a0, 5        # Load n into $a0
    li $a1, 2        # Load k into $a1
    jal bin_coef     # Call bin_coef function
    move $t0, $v0    # Move the result to $t0

    # Print the result
    la $a0, print_str
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    # Exit the program
    li $v0, 10
    syscall

bin_coef:
    # Base cases
    beq $a1, $zero, return_one   # if k == 0, return 1
    beq $a0, $a1, return_one     # if n == k, return 1

    # Recursive cases
    addi $sp, $sp, -8    # Allocate space for saved registers
    sw $ra, 4($sp)       # Save return address
    sw $a1, 0($sp)       # Save the current value of k

    # First recursive call: bin_coef(n-1, k-1)
    addiu $a0, $a0, -1   # Decrement n
    addiu $a1, $a1, -1   # Decrement k
    jal bin_coef         # Recursive call
    lw $a1, 0($sp)       # Restore k
    sw $v0, 0($sp)       # Save result of bin_coef(n-1, k-1)

    # Second recursive call: bin_coef(n-1, k)
    addiu $a0, $a0, 1    # Restore original n (by incrementing)
    jal bin_coef         # Recursive call
    lw $t1, 0($sp)       # Load the saved result of bin_coef(n-1, k-1)

    add $v0, $v0, $t1    # Add results of recursive calls

    lw $ra, 4($sp)       # Restore return address
    addi $sp, $sp, 8     # Deallocate space for saved registers
    jr $ra               # Return to caller

return_one:
    li $v0, 1            # Return 1
    jr $ra               # Return to caller
