.data
msg_positivo: .asciiz "Resultado positivo: "   # Mensaje para resultados positivos.
msg_negativo: .asciiz "Resultado negativo, memoria limpiada.\n"  # Mensaje para resultados negativos.

.text
.globl main

main:
    # Inicializa registros con valores
    li $t1, 7       # Valor de ejemplo para $t1
    li $t2, 10      # Valor de ejemplo para $t2

    # Realiza la substracción, resultado en $t3
    sub $t3, $t1, $t2   # Substrae $t2 de $t1 y almacena el resultado en $t3

    # Verifica si el resultado es positivo
    bgez $t3, print_result   # Si $t3 es positivo o cero, ir a print_result
    j error                  # Si $t3 es negativo, ir a error

print_result:
    li $v0, 4                # Código de syscall para imprimir cadena de texto
    la $a0, msg_positivo     # Carga la dirección del mensaje positivo
    syscall                  # Imprime el mensaje

    move $a0, $t3            # Mueve el resultado a $a0 para imprimir
    li $v0, 1                # Código de syscall para imprimir entero
    syscall                  # Imprime el resultado

    j exit                   # Salta a la etiqueta exit

error:
    li $v0, 4                # Código de syscall para imprimir cadena de texto
    la $a0, msg_negativo     # Carga la dirección del mensaje negativo
    syscall                  # Imprime el mensaje de error

    # Asumiendo que deseas limpiar $t3
    li $t3, 0                # Limpia el contenido de $t3 (establece a cero)

exit:
    li $v0, 10               # Código de syscall para salir del programa
    syscall                  # Ejecuta la salida del programa
