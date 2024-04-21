.data
inputNumber: .asciiz "Digita el número de iteraciones: "
outputValue: .asciiz "El valor aproximado de pi es: "
.text 
.globl main

main: 
    # Imprime el mensaje para ingresar el número de iteraciones
    la $a0, inputNumber
    li $v0, 4
    syscall

    # Lee el número de iteraciones
    li $v0, 5
    syscall
    move $t0, $v0

    # Inicializa las variables
    li $t1, 0               # n = 0
    li $t2, 1               # multiplicador para la serie alternante
    li $t3, 0               # Registro temporal para el cero en punto flotante
    mtc1 $t3, $f3           # sum = 0.0 (registro en punto flotante)
    cvt.s.w $f3, $f3        # Convierte sum a punto flotante

forloop:
    # Calcula el denominador (2n+1)
    mul $t3, $t1, 2
    addi $t3, $t3, 1
    
    # Convierte los valores enteros a punto flotante
    mtc1 $t3, $f1
    cvt.s.w $f1, $f1        # Convierte el denominador a punto flotante
    mtc1 $t2, $f2
    cvt.s.w $f2, $f2        # Convierte el multiplicador a punto flotante

    # Divide el multiplicador por el denominador
    div.s $f0, $f2, $f1

    # Suma el resultado a la suma total
    add.s $f3, $f3, $f0

    # Prepara la siguiente iteración
    mul $t2, $t2, -1        # Cambia el signo del multiplicador
    addi $t1, $t1, 1        # Incrementa n

    # Verifica la condición del bucle
    ble $t1, $t0, forloop

endfor:
    # Multiplica la suma por 4 para obtener pi
    li $t3, 4
    mtc1 $t3, $f12
    cvt.s.w $f12, $f12      # Convierte 4 a punto flotante
    mul.s $f3, $f3, $f12

    # Imprime el resultado
    la $a0, outputValue
    li $v0, 4
    syscall

    # Imprime el valor calculado de pi
    mov.s $f12, $f3
    li $v0, 2
    syscall

    # Sale del programa
    li $v0, 10
    syscall
