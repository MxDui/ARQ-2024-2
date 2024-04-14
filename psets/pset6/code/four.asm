.data
dividend: .word 101  # Dividendo
divisor:  .word 21   # Divisor
quotient_label: .asciiz "Cociente: "  # Etiqueta para imprimir el cociente.
remainder_label: .asciiz "\nResiduo: "  # Etiqueta para imprimir el residuo.

.text
.globl main

main:
    # Carga los valores del dividendo y divisor
    lw $t0, dividend
    lw $t1, divisor

    # Inicializa el cociente y el residuo
    li $v0, 0       # Inicializa el cociente a 0
    move $v1, $t0   # Inicializa el residuo con el valor del dividendo

    # Verifica si el divisor es cero
    beq $t1, $zero, exit  # Salir del programa si el divisor es 0

division_loop:
    # Comprueba si el residuo es menor que el divisor
    slt $t2, $v1, $t1     # $t2 = 1 si $v1 < $t1, de lo contrario $t2 = 0
    bne $t2, $zero, print_result  # Si el residuo es menor que el divisor, ir a imprimir resultado

    # Resta el divisor del residuo y aumenta el cociente
    sub $v1, $v1, $t1     # Residuo = Residuo - Divisor
    addi $v0, $v0, 1      # Cociente = Cociente + 1

    j division_loop       # Continúa el bucle de división

print_result:
    # Almacena los resultados en $v0 y $v1 antes de imprimir
    move $a0, $v0         # Prepara el cociente para imprimir
    move $a1, $v1         # Prepara el residuo para imprimir

    # Imprime la etiqueta para el cociente
    la $a0, quotient_label
    li $v0, 4             # Código de syscall para imprimir cadena
    syscall               # Imprime la etiqueta del cociente

    # Imprime el cociente
    move $a0, $v0         # Mueve el cociente a $a0
    li $v0, 1             # Código de syscall para imprimir entero
    syscall               # Imprime el cociente

    # Imprime la etiqueta para el residuo
    la $a0, remainder_label
    li $v0, 4             # Código de syscall para imprimir cadena
    syscall               # Imprime la etiqueta del residuo

    # Imprime el residuo
    move $a0, $v1         # Mueve el residuo a $a0
    li $v0, 1             # Código de syscall para imprimir entero
    syscall               # Imprime el residuo

    # Syscall de salida: termina el programa limpiamente
    li $v0, 10            # Código de syscall para salir
    syscall               # Ejecuta la syscall de salida

exit:
    # Sale del programa si el divisor es cero
    li $v0, 10            # Código de syscall para salir
    syscall               # Ejecuta la syscall para salir
