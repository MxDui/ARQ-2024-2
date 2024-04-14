.data
msg: .asciiz "Hola.\n"   # Define el mensaje que se va a imprimir.

.text
.globl main

main:
    li $v0, 5              # Código de syscall para leer un entero (read_int).
    syscall                # Lee el entero de la entrada del usuario.
    move $t0, $v0          # Mueve el entero leído al registro $t0 para usarlo como contador del bucle.

    li $t1, 0              # Inicializa el contador del bucle a 0.

loop:
    bge $t1, $t0, endloop  # Si $t1 es mayor o igual a $t0, salta a endloop.
    li $v0, 4              # Código de syscall para imprimir una cadena (print_string).
    la $a0, msg            # Carga la dirección del mensaje en $a0.
    syscall                # Imprime el mensaje.
    addi $t1, $t1, 1       # Incrementa el contador del bucle.
    j loop                 # Salta de nuevo al inicio del bucle.

endloop:
    li $v0, 10             # Código de syscall para salir del programa (exit).
    syscall                # Sale del programa.
