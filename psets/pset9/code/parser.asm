.data
input_buffer: .space 256  # Allocate 256 bytes for input buffer
prompt: .asciiz "Enter command: "
error_msg: .asciiz "Unknown command. Try again.\n"
exit_msg: .asciiz "Exiting the interpreter.\n"
help_msg: .asciiz "Available commands: help, joke, song, rev, cat, exit, date, calc\n"
help_full: .asciiz "help: Prints information about available commands and their options. If called without arguments, it prints a list of available commands.\nSynopsis: help [arg]\nArguments: arg - Prints the description and options of the command 'arg'.\n"
help_joke: .asciiz "joke: Displays a random joke.\n"
help_song: .asciiz "song: Plays a short song with at least 10 notes.\n"
help_rev: .asciiz "rev [file]: Prints the reverse of a string. If no file is specified, it uses standard input.\n"
help_cat: .asciiz "cat file1 [file2]: Concatenates two files and displays the result.\n"
help_date: .asciiz "date: Displays the current date.\n"
help_calc: .asciiz "calc: Performs a simple arithmetic operation (addition, subtraction, multiplication, division).\n"
joke1: .asciiz "Why don't scientists trust atoms? Because they make up everything.\n"
joke2: .asciiz "Why did the chicken go to the seance? To talk to the other side.\n"
joke3: .asciiz "What do you call fake spaghetti? An impasta.\n"
song_note: .asciiz "Playing a note...\n"
file_buffer: .space 1024  # Allocate 1 KB for file buffer
counter: .word 0  # Simple counter
frequencies: .word 262, 294, 330, 349, 392, 440, 494, 523, 587, 659  # Example frequencies (C4 to E5)
file1_msg: .asciiz "Enter first file name: "
file2_msg: .asciiz "Enter second file name: "
date_msg: .asciiz "Current date: 2024-05-18\n"
calc_msg: .asciiz "Enter operation (e.g., 5 + 3): "

.text
.globl main
main:
    j print_prompt

print_prompt:
    la $a0, prompt
    li $v0, 4
    syscall
    j read_input

read_input:
    la $a0, input_buffer
    li $a1, 100
    li $v0, 8
    syscall
    j parse_command

parse_command:
    # Parsing for 'help'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'h'
    bne $t2, $t3, not_help
    lb $t2, 1($t1)
    li $t3, 'e'
    bne $t2, $t3, not_help
    lb $t2, 2($t1)
    li $t3, 'l'
    bne $t2, $t3, not_help
    lb $t2, 3($t1)
    li $t3, 'p'
    bne $t2, $t3, not_help
    j handle_help

not_help:
    # Parse for 'joke'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'j'
    bne $t2, $t3, not_joke
    lb $t2, 1($t1)
    li $t3, 'o'
    bne $t2, $t3, not_joke
    lb $t2, 2($t1)
    li $t3, 'k'
    bne $t2, $t3, not_joke
    lb $t2, 3($t1)
    li $t3, 'e'
    bne $t2, $t3, not_joke
    j handle_joke

not_joke:
    # Parse for 'song'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 's'
    bne $t2, $t3, not_song
    lb $t2, 1($t1)
    li $t3, 'o'
    bne $t2, $t3, not_song
    lb $t2, 2($t1)
    li $t3, 'n'
    bne $t2, $t3, not_song
    lb $t2, 3($t1)
    li $t3, 'g'
    bne $t2, $t3, not_song
    j handle_song

not_song:
    # Parse for 'rev'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'r'
    bne $t2, $t3, not_rev
    lb $t2, 1($t1)
    li $t3, 'e'
    bne $t2, $t3, not_rev
    lb $t2, 2($t1)
    li $t3, 'v'
    bne $t2, $t3, not_rev
    j handle_rev

not_rev:
    # Parse for 'cat'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'c'
    bne $t2, $t3, not_cat
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, not_cat
    lb $t2, 2($t1)
    li $t3, 't'
    bne $t2, $t3, not_cat
    j handle_cat

not_cat:
    # Parse for 'exit'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'e'
    bne $t2, $t3, not_exit
    lb $t2, 1($t1)
    li $t3, 'x'
    bne $t2, $t3, not_exit
    lb $t2, 2($t1)
    li $t3, 'i'
    bne $t2, $t3, not_exit
    lb $t2, 3($t1)
    li $t3, 't'
    bne $t2, $t3, not_exit
    j handle_exit

not_exit:
    # Parse for 'date'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'd'
    bne $t2, $t3, not_date
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, not_date
    lb $t2, 2($t1)
    li $t3, 't'
    bne $t2, $t3, not_date
    lb $t2, 3($t1)
    li $t3, 'e'
    bne $t2, $t3, not_date
    j handle_date

not_date:
    # Parse for 'calc'
    la $t1, input_buffer
    lb $t2, 0($t1)
    li $t3, 'c'
    bne $t2, $t3, handle_error
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, handle_error
    lb $t2, 2($t1)
    li $t3, 'l'
    bne $t2, $t3, handle_error
    lb $t2, 3($t1)
    li $t3, 'c'
    bne $t2, $t3, handle_error
    j handle_calc

handle_help:
    # Check if there is an argument after 'help'
    la $t1, input_buffer + 5  # Assume command is at the beginning, skip "help "
    lb $t2, 0($t1)
    beqz $t2, print_help_msg  # If no argument, print general help message

    # Parse the argument for specific command help
    lb $t2, 0($t1)
    li $t3, 'j'
    bne $t2, $t3, not_help_joke
    lb $t2, 1($t1)
    li $t3, 'o'
    bne $t2, $t3, not_help_joke
    lb $t2, 2($t1)
    li $t3, 'k'
    bne $t2, $t3, not_help_joke
    lb $t2, 3($t1)
    li $t3, 'e'
    bne $t2, $t3, not_help_joke
    j print_help_joke

not_help_joke:
    lb $t2, 0($t1)
    li $t3, 's'
    bne $t2, $t3, not_help_song
    lb $t2, 1($t1)
    li $t3, 'o'
    bne $t2, $t3, not_help_song
    lb $t2, 2($t1)
    li $t3, 'n'
    bne $t2, $t3, not_help_song
    lb $t2, 3($t1)
    li $t3, 'g'
    bne $t2, $t3, not_help_song
    j print_help_song

not_help_song:
    lb $t2, 0($t1)
    li $t3, 'r'
    bne $t2, $t3, not_help_rev
    lb $t2, 1($t1)
    li $t3, 'e'
    bne $t2, $t3, not_help_rev
    lb $t2, 2($t1)
    li $t3, 'v'
    bne $t2, $t3, not_help_rev
    j print_help_rev

not_help_rev:
    lb $t2, 0($t1)
    li $t3, 'c'
    bne $t2, $t3, not_help_cat
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, not_help_cat
    lb $t2, 2($t1)
    li $t3, 't'
    bne $t2, $t3, not_help_cat
    j print_help_cat

not_help_cat:
    lb $t2, 0($t1)
    li $t3, 'd'
    bne $t2, $t3, not_help_date
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, not_help_date
    lb $t2, 2($t1)
    li $t3, 't'
    bne $t2, $t3, not_help_date
    lb $t2, 3($t1)
    li $t3, 'e'
    bne $t2, $t3, not_help_date
    j print_help_date

not_help_date:
    lb $t2, 0($t1)
    li $t3, 'c'
    bne $t2, $t3, not_help_calc
    lb $t2, 1($t1)
    li $t3, 'a'
    bne $t2, $t3, not_help_calc
    lb $t2, 2($t1)
    li $t3, 'l'
    bne $t2, $t3, not_help_calc
    lb $t2, 3($t1)
    li $t3, 'c'
    bne $t2, $t3, not_help_calc
    j print_help_calc

not_help_calc:
    j print_help_msg

print_help_msg:
    la $a0, help_full
    li $v0, 4
    syscall
    la $a0, help_msg
    li $v0, 4
    syscall
    j print_prompt

print_help_joke:
    la $a0, help_joke
    li $v0, 4
    syscall
    j print_prompt

print_help_song:
    la $a0, help_song
    li $v0, 4
    syscall
    j print_prompt

print_help_rev:
    la $a0, help_rev
    li $v0, 4
    syscall
    j print_prompt

print_help_cat:
    la $a0, help_cat
    li $v0, 4
    syscall
    j print_prompt

print_help_date:
    la $a0, help_date
    li $v0, 4
    syscall
    j print_prompt

print_help_calc:
    la $a0, help_calc
    li $v0, 4
    syscall
    j print_prompt

handle_joke:
    la $t0, counter
    lw $t1, 0($t0)        # Load the value of the counter
    addi $t1, $t1, 1      # Increment the counter
    sw $t1, 0($t0)        # Store it back

    li $t2, 3
    rem $a0, $t1, $t2     # Calculate the remainder of the counter divided by 3

    # Based on remainder, jump to print different jokes
    beqz $a0, print_joke1
    li $t3, 1
    beq $a0, $t3, print_joke2
    j print_joke3

print_joke1:
    la $a0, joke1
    j display_joke

print_joke2:
    la $a0, joke2
    j display_joke

print_joke3:
    la $a0, joke3

display_joke:
    li $v0, 4
    syscall
    j print_prompt

handle_song:
    la $t0, frequencies  # Load address of the frequencies array
    li $t1, 10           # Set counter for 10 notes

play_note:
    lw $a0, 0($t0)       # Load frequency from array
    li $a1, 500          # Set duration of the note (500 ms)
    li $a2, 127          # Set volume (optional, if supported by your syscall)
    li $v0, 33           # Syscall number for playing sound
    syscall              # Play the note

    la $a0, song_note    # Display "Playing a note..."
    li $v0, 4            # Syscall number for print string
    syscall

    addiu $t0, $t0, 4    # Move to the next frequency in the array
    addi $t1, $t1, -1    # Decrement the counter
    bgtz $t1, play_note  # Continue playing if there are more notes

    j print_prompt       # Return to prompt after playing the song

handle_rev:
    la $t1, input_buffer + 4  # Assume command is at the beginning, skip "rev "
    lb $t2, 0($t1)
    beqz $t2, rev_from_input  # If no argument, read from standard input

    # Open the file
    la $a0, input_buffer + 4  # Get the file name
    li $a1, 0                 # Open for reading
    li $v0, 13                # Syscall for open file
    syscall
    move $s0, $v0             # Save file descriptor

    # Read from file
    li $v0, 14                # Syscall for read file
    move $a0, $s0             # File descriptor
    la $a1, input_buffer      # Buffer to store data
    li $a2, 256               # Number of bytes to read
    syscall
    move $a0, $v0             # Number of bytes read

    # Close the file
    move $a0, $s0             # File descriptor
    li $v0, 16                # Syscall for close file
    syscall

    # Reverse the string read from the file
    la $a0, input_buffer
    move $a1, $v0             # Number of bytes read
    jal reverse_string
    j print_prompt

rev_from_input:
    # Read from standard input
    li $v0, 8                # Syscall for read string
    la $a0, input_buffer
    li $a1, 256
    syscall
    move $a0, $v0            # Number of bytes read

    # Reverse the string read from standard input
    la $a0, input_buffer
    move $a1, $v0            # Number of bytes read
    jal reverse_string
    j print_prompt

reverse_string:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    move $s0, $a0            # $s0 = start of the string
    add $t1, $s0, $a1        # $t1 = end of the string
    sub $t1, $t1, 1          # Adjust for zero-index

reverse_loop:
    blt $s0, $t1, swap_characters
    j end_reverse_string

swap_characters:
    lb $a2, 0($s0)           # Load byte from start
    lb $a3, 0($t1)           # Load byte from end
    sb $a2, 0($t1)           # Store byte at end
    sb $a3, 0($s0)           # Store byte at start
    addi $s0, $s0, 1         # Move forward
    addi $t1, $t1, -1        # Move backward
    j reverse_loop           # Continue swapping

end_reverse_string:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    addi $sp, $sp, 8
    jr $ra

handle_cat:
    # Get the first file name from user input
    la $a0, file1_msg
    li $v0, 4
    syscall
    la $a0, input_buffer
    li $a1, 256
    li $v0, 8                  # Read string syscall
    syscall
    
    # Open first file
    la $a0, input_buffer       # Filename from input buffer
    li $a1, 0                  # Open for reading
    li $v0, 13                 # Open file syscall
    syscall
    move $s0, $v0              # Save file descriptor of first file
    
    # Read and display first file
    li $v0, 14                 # Read from file syscall
    move $a0, $s0              # File descriptor
    la $a1, input_buffer       # Buffer to store data
    li $a2, 256                # Read up to 256 bytes
    syscall
    beqz $v0, close_file1      # If no bytes read, close file
    la $a0, input_buffer       # Pointer to data
    li $v0, 4                  # Display string syscall
    syscall
    
close_file1:
    move $a0, $s0              # File descriptor
    li $v0, 16                 # Close file syscall
    syscall

    # Get the second file name
    la $a0, file2_msg
    li $v0, 4
    syscall
    la $a0, input_buffer
    li $a1, 256
    li $v0, 8                  # Read string syscall
    syscall
    
    # Open second file
    la $a0, input_buffer       # Filename from input buffer
    li $a1, 0                  # Open for reading
    li $v0, 13                 # Open file syscall
    syscall
    move $s1, $v0              # Save file descriptor of second file
    
    # Read and display second file
    li $v0, 14                 # Read from file syscall
    move $a0, $s1              # File descriptor
    la $a1, input_buffer       # Buffer to store data
    li $a2, 256                # Read up to 256 bytes
    syscall
    beqz $v0, close_file2      # If no bytes read, close file
    la $a0, input_buffer       # Pointer to data
    li $v0, 4                  # Display string syscall
    syscall
    
close_file2:
    move $a0, $s1              # File descriptor
    li $v0, 16                 # Close file syscall
    syscall

    j print_prompt             # Return to main prompt

handle_date:
    la $a0, date_msg
    li $v0, 4
    syscall
    j print_prompt

handle_calc:
    la $a0, calc_msg
    li $v0, 4
    syscall

    la $a0, input_buffer
    li $a1, 256
    li $v0, 8
    syscall

    # Parse the input for calculation
    la $t1, input_buffer
    lb $t2, 0($t1)
    beqz $t2, handle_error  # If no input, handle error

    # Extract first operand
    li $v0, 5
    syscall
    move $t3, $v0

    # Extract operator
    lb $t2, 1($t1)
    move $t4, $t2

    # Extract second operand
    li $v0, 5
    syscall
    move $t5, $v0

    # Perform calculation based on operator
    li $v0, 1
    li $t6, '+'
    beq $t4, $t6, calc_add
    li $t6, '-'
    beq $t4, $t6, calc_sub
    li $t6, '*'
    beq $t4, $t6, calc_mul
    li $t6, '/'
    beq $t4, $t6, calc_div
    j handle_error

calc_add:
    add $a0, $t3, $t5
    j print_result

calc_sub:
    sub $a0, $t3, $t5
    j print_result

calc_mul:
    mul $a0, $t3, $t5
    j print_result

calc_div:
    div $t3, $t5
    mflo $a0
    j print_result

print_result:
    li $v0, 1
    syscall
    j print_prompt

handle_error:
    la $a0, error_msg
    li $v0, 4
    syscall
    j print_prompt

handle_exit:
    la $a0, exit_msg
    li $v0, 4
    syscall
    li $v0, 10
    syscall
