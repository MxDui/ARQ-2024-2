.data
prompt: .asciiz ">> "
unknown_cmd: .asciiz "Comando desconocido.\n"
help_msg: .asciiz "Comandos disponibles: help, joke, song, rev, cat, exit\n"
buffer: .space 100       # Buffer para almacenar entrada del usuario
error_arg: .asciiz "Error en argumentos.\n"
joke1: .asciiz "Why do programmers prefer dark mode? Because light attracts bugs.\n"
joke2: .asciiz "Why don't programmers like nature? It has too many bugs.\n"
joke3: .asciiz "How do you comfort a JavaScript bug? You console it.\n"
help_command: .asciiz "help"
joke_command: .asciiz "joke"
song_command: .asciiz "song"
rev_command: .asciiz "rev"
cat_command: .asciiz "cat"
exit_command: .asciiz "exit"
song_msg: .asciiz "Playing a song...\n"

.text

.globl main
main:
    li $v0, 4
    la $a0, prompt
    syscall
    
    li $v0, 8
    la $a0, buffer
    li $a1, 100
    syscall

    # Llamar a una función para limpiar el buffer
    la $a0, buffer
    jal clean_input

    # Continuar con la comparación
    la $a0, buffer
    la $a1, help_command
    jal string_compare
    beq $v0, 1, help

    la $a0, buffer
    la $a1, joke_command
    jal string_compare
    beq $v0, 1, joke

    la $a0, buffer
    la $a1, song_command
    jal string_compare
    beq $v0, 1, song

    la $a0, buffer
    la $a1, rev_command
    jal string_compare
    beq $v0, 1, rev

    la $a0, buffer
    la $a1, cat_command
    jal string_compare
    beq $v0, 1, cat

    la $a0, buffer
    la $a1, exit_command
    jal string_compare
    beq $v0, 1, exit

    # Si no coincide ningún comando
    li $v0, 4
    la $a0, unknown_cmd
    syscall
    j main
# Implementar string_compare que establece $v0 a 1 si las cadenas son iguales, 0 si no
.text
string_compare:
    push_registers:           # Save registers
        addi $sp, $sp, -8
        sw $ra, 4($sp)
        sw $a1, 0($sp)

    compare_loop:
        lb $t0, 0($a0)        # Load byte from string1
        lb $t1, 0($a1)        # Load byte from string2
        beq $t0, $zero, end_of_string1  # Check if end of string1
        bne $t0, $t1, strings_not_equal  # If chars do not match
        addi $a0, $a0, 1      # Move to next char in string1
        addi $a1, $a1, 1      # Move to next char in string2
        j compare_loop

    end_of_string1:
        lb $t1, 0($a1)        # Load byte from string2
        beq $t1, $zero, strings_equal  # Check if end of string2
        j strings_not_equal

    strings_equal:
        li $v0, 1
        j end_string_compare

    strings_not_equal:
        li $v0, 0

    end_string_compare:
    pop_registers:            # Restore registers
        lw $a1, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 8
        jr $ra


clean_input:
    li $t1, 0            # Index for writing clean chars
    clean_loop:
        lb $t0, 0($a0)   # Load byte
        beq $t0, $zero, clean_done  # End of string
        beq $t0, 10, skip_char      # Skip newline
        beq $t0, 13, skip_char      # Skip carriage return
        beq $t0, 32, skip_char      # Skip space
        sb $t0, 0($a0)  # Store byte
        addi $a0, $a0, 1
        addi $t1, $t1, 1
        j clean_loop

    skip_char:
        addi $a0, $a0, 1  # Move to next char
        j clean_loop

    clean_done:
        sb $zero, 0($t1)  # Null-terminate the cleaned string
        jr $ra

help:
    li $v0, 4
    la $a0, help_msg
    syscall
    j main

joke:
    # Aquí se podría usar un generador aleatorio para seleccionar un chiste
    li $v0, 4
    la $a0, joke1  # Cambiar por la selección aleatoria
    syscall
    j main


song:
    li $v0, 4
    la $a0, song_msg
    syscall
    # Ejemplo de generación de notas musicales (implementar según syscalls disponibles)
    li $v0, 31            # Suponiendo syscall 31 para notas musicales
    li $a0, 440           # Frecuencia de A4, por ejemplo
    li $a1, 1000          # Duración en milisegundos
    syscall
    # Repetir para otras notas
    j main


rev:
    # Revertir una cadena. Implementación depende de la entrada
    j main

cat:
    # Concatenar archivos. Implementación depende de los argumentos
    j main

exit:
    # Confirmación de salida
    li $v0, 10
    syscall
