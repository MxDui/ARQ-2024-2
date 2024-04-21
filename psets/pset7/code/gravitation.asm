.data
G: .float 6.674e-11     # Constante gravitacional
m1: .float 5.972e24     # Masa de la Tierra en kg
m2: .float 7.348e22     # Masa de la Luna en kg
r: .float 3.844e8       # Distancia entre la Tierra y la Luna en metros
result_message: .asciiz "La fuerza gravitacional es: "

.text
.globl main

main:
    lwc1 $f0, G
    lwc1 $f1, m1
    lwc1 $f2, m2
    lwc1 $f3, r
    mul.s $f4, $f0, $f1     # G * m1
    mul.s $f4, $f4, $f2     # G * m1 * m2
    mul.s $f5, $f3, $f3     # r^2
    div.s $f6, $f4, $f5     # (G * m1 * m2) / r^2

    # Mostrar resultado
    li $v0, 4
    la $a0, result_message
    syscall
    li $v0, 2
    mov.s $f12, $f6
    syscall

    # Salir del programa
    li $v0, 10
    syscall
