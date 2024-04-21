.data
 line_jump:	.asciiz "\n"
 not_quad_equation_error: .asciiz "La ecuación no es cuadrática\n"
 imaginary_roots_error: .asciiz "La ecuación tiene raíces imaginarias\n"
 a: .asciiz "Escribe a="
 ve: .asciiz "Escribe b="
 c: .asciiz "Escribe c="
 x1: .asciiz "x1 = "
 x2: .asciiz "x2 = "

.text
main:

 la $a0, line_jump # Imprimir salto de línea
 syscall

 la $a0, a # Solicitar el coeficiente a
 syscall

 li $v0, 6 # Leer número flotante
 syscall

 li.s $f4, 0.0
 c.eq.s $f0, $f4 # Comprueba si a = 0
 bc1t not_quad_equation # Si a = 0, no es una ecuación cuadrática

 mov.s $f20, $f0 # Guarda a en $f20

 la $a0, ve # Solicitar el coeficiente b
 li $v0, 4
 syscall

 li $v0, 6 # Leer número flotante
 syscall

 mov.s $f21, $f0 # Guarda b en $f21

 la $a0, c # Solicitar el coeficiente c
 li $v0, 4
 syscall

 li $v0, 6 # Leer número flotante
 syscall

 mov.s $f22, $f0 # Guarda c en $f22

 la $a0, line_jump # Imprimir salto de línea
 li $v0, 4
 syscall

 mul.s $f7, $f21, $f21 # Calcula b^2
 mul.s $f8, $f20, $f22 # Calcula ac
 li.s $f9, 4.0
 mul.s $f8, $f9, $f8 # Calcula 4ac
 sub.s $f7, $f7, $f8 # Calcula b^2 - 4ac

 li.s $f8, 0.0
 c.lt.s $f7, $f8 # Comprueba si el discriminante es negativo
 bc1t imaginary_roots # Si es negativo, las raíces son imaginarias

 mov.s $f12, $f7
 jal bsqrt_implementation # Calcula la raíz cuadrada de b^2 - 4ac

 neg.s $f5, $f21 # f5 = -b
 add.s $f6, $f5, $f0 # f6 = -b + sqrt(discriminante)
 sub.s $f7, $f5, $f0 # f7 = -b - sqrt(discriminante)

 li.s $f8, 2.0
 mul.s $f4, $f20, $f8 # f4 = 2a
 div.s $f8, $f6, $f4 # f8 = raíz x1
 div.s $f9, $f7, $f4 # f9 = raíz x2

 la $a0, x1 # Imprime "x1 = "
 syscall

 mov.s $f12, $f8 # Imprime x1
 li $v0, 2
 syscall

 la $a0, line_jump # Imprime salto de línea
 li $v0, 4
 syscall

 la $a0, x2 # Imprime "x2 = "
 syscall

 mov.s $f12, $f9 # Imprime x2
 li $v0, 2
 syscall

 li $v0, 10 # Termina el programa
 syscall

imaginary_roots:
 la $a0, imaginary_roots_error # Imprime mensaje de raíces imaginarias
 syscall

 li $v0, 10 # Termina el programa
 syscall

not_quad_equation:
 la $a0, line_jump # Imprime salto de línea
 li $v0, 4
 syscall

 la $a0, not_quad_equation_error # Imprime mensaje de no cuadrática
 syscall

 li $v0, 10 # Termina el programa
 syscall


.text
bsqrt_implementation:
    li.s    $f4, 0.0
    c.eq.s  $f12, $f4         # Comprueba si la entrada x es igual a 0
    bc1t    zero              # Si es verdadero, salta a 'zero' donde se configura sqrt(x) = 0
    c.lt.s  $f12, $f4         # Comprueba si la entrada x es negativa
    bc1t    error             # Si es verdadero, salta a 'error' donde se maneja el error

    li.s    $f13, 2.0         # Divisor para la primera estimación
    div.s   $f14, $f12, $f13  # estimación inicial = x / 2

loop:
    div.s   $f6, $f12, $f14   # r = x / estimación actual
    add.s   $f5, $f14, $f6    # f5 = estimación actual + r
    div.s   $f7, $f5, $f13    # nueva estimación = (estimación actual + r) / 2
    sub.s   $f8, $f7, $f14    # Calcula el cambio para verificar la convergencia
    abs.s   $f8, $f8          # Toma el valor absoluto del cambio
    li.s    $f9, 0.0001       # Umbral de convergencia
    c.lt.s  $f8, $f9          # Comprueba si el cambio es menor que el umbral
    bc1t    done              # Si ha convergido, salir del bucle
    mov.s   $f14, $f7         # Actualiza la estimación
    b       loop
    nop

zero:
    mov.s   $f0, $f4          # Devuelve directamente 0 como sqrt(0)
    jr      $ra

error:
    li.s    $f0, -1.0         # Devuelve -1 como condición de error
    jr      $ra

done:
    mov.s   $f0, $f14         # Establece la última estimación como el resultado
    jr      $ra
