.data
prompt: .asciiz "Ingrese un número flotante: "
result_message: .asciiz "El promedio es: "

.text
.globl main

main:
    li $t0, 0       # Contador de números ingresados
    li.s $f1, 0.0    # Suma total de números

input_loop:
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 6       # Leer número flotante
    syscall
    add.s $f1, $f1, $f0  # Sumar número al total

    addi $t0, $t0, 1
    li $t1, 5
    blt $t0, $t1, input_loop  # Bucle hasta que se hayan introducido 5 números

    li.s $f2, 5.0
    div.s $f1, $f1, $f2  # Dividir la suma total por 5

    # Mostrar resultado
    li $v0, 4
    la $a0, result_message
    syscall
    li $v0, 2
    mov.s $f12, $f1
    syscall

    # Salir del programa
    li $v0, 10
    syscall
