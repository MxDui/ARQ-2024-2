.data
prompt: .asciiz "Ingrese un número flotante: "   # Cadena de texto para pedir al usuario un número flotante
result_message: .asciiz "El promedio es: "       # Mensaje para mostrar antes del resultado del promedio

.text
.globl main

main:
    li $t0, 0       # Inicializa el contador de números ingresados a 0
    li.s $f1, 0.0    # Inicializa la suma total de los números a 0.0

input_loop:
    li $v0, 4       # Prepara el syscall para imprimir una cadena de texto
    la $a0, prompt  # Carga la dirección de la cadena 'prompt' en $a0
    syscall         # Ejecuta el syscall para mostrar el mensaje "Ingrese un número flotante: "

    li $v0, 6       # Prepara el syscall para leer un número flotante
    syscall         # Ejecuta el syscall para leer el número flotante y lo almacena en $f0

    add.s $f1, $f1, $f0  # Suma el número ingresado al total acumulado en $f1

    addi $t0, $t0, 1     # Incrementa el contador de números ingresados
    li $t1, 5            # Carga el número 5 en $t1, que representa la cantidad total de números a ingresar
    blt $t0, $t1, input_loop  # Si el contador es menor que 5, salta de nuevo a input_loop para leer otro número

    li.s $f2, 5.0        # Carga el número 5.0 en $f2, que se usará para dividir la suma total y obtener el promedio
    div.s $f1, $f1, $f2  # Divide la suma total por 5 y almacena el resultado en $f1

    # Mostrar resultado
    li $v0, 4            # Prepara el syscall para imprimir una cadena de texto
    la $a0, result_message  # Carga la dirección de la cadena 'result_message' en $a0
    syscall              # Ejecuta el syscall para mostrar el mensaje "El promedio es: "

    li $v0, 2            # Prepara el syscall para imprimir un número flotante
    mov.s $f12, $f1      # Mueve el resultado del promedio almacenado en $f1 a $f12
    syscall              # Ejecuta el syscall para imprimir el número flotante

    # Salir del programa
    li $v0, 10           # Prepara el syscall para terminar la ejecución del programa
    syscall              # Ejecuta el syscall para salir del programa
