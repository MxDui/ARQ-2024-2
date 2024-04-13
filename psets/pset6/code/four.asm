.data
# Variables para almacenar los números a dividir
dividend: .word 15   # Cambia 15 al dividendo deseado
divisor:  .word 3    # Cambia 3 al divisor deseado

.text
main:
    # Carga los valores del dividendo y divisor
    lw $t0, dividend
    lw $t1, divisor

    # Inicializa el cociente y el residuo
    li $v0, 0   # Cociente inicializado a 0
    move $v1, $t0  # Residuo inicializado al dividendo

    # Verifica si el divisor es 0
    beq $t1, $zero, exit  # Sal del programa si el divisor es 0

division_loop:
    # Verifica si el residuo es menor que el divisor
    slt $t2, $v1, $t1  # $t2 = 1 si $v1 < $t1, de lo contrario $t2 = 0
    bne $t2, $zero, print_result  # Si residuo < divisor, ve a imprimir resultado

    # Resta el divisor del residuo y aumenta el cociente
    sub $v1, $v1, $t1  # Residuo = Residuo - Divisor
    addi $v0, $v0, 1   # Cociente = Cociente + 1

    j division_loop  # Continúa el bucle de división

print_result:
    # Imprime el cociente
    li $v0, 1          # Código de llamada al sistema para imprimir un entero
    move $a0, $v0      # Mueve el cociente al registro de argumentos
    syscall            # Realiza la llamada al sistema para imprimir

    # Imprime el residuo
    move $a0, $v1      # Mueve el residuo al registro de argumentos
    syscall            # Realiza la llamada al sistema para imprimir

    # Terminar la ejecución del programa
    li $v0, 10         # Código de llamada al sistema para salir
    syscall            # Realiza la llamada al sistema para salir

exit:
    # Sal del programa
    li $v0, 10         # Código de llamada al sistema para salir
    syscall            # Realiza la llamada al sistema para salir
