.data
prompt_a: .asciiz "Ingrese a: "
prompt_b: .asciiz "Ingrese b: "
prompt_c: .asciiz "Ingrese c: "
message_no_real: .asciiz "La ecuacion no tiene soluciones reales.\n"
message_x1: .asciiz "x1 = "
message_x2: .asciiz "x2 = "

.text
.globl main

main:
    # Input a
    li $v0, 4
    la $a0, prompt_a
    syscall
    li $v0, 6
    syscall
    mov.s $f0, $f0   # a -> $f0

    # Input b
    li $v0, 4
    la $a0, prompt_b
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0   # b -> $f1

    # Input c
    li $v0, 4
    la $a0, prompt_c
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0   # c -> $f2

    # Calculating discriminant b^2 - 4ac
    mul.s $f3, $f1, $f1  # b^2 -> $f3
    li.s $f4, 4.0
    mul.s $f5, $f0, $f2  # ac -> $f5
    mul.s $f5, $f4, $f5  # 4ac -> $f5
    sub.s $f6, $f3, $f5  # b^2 - 4ac -> $f6 (discriminante)

    # Check if discriminant is negative
    li.s $f7, 0.0
    c.lt.s $f6, $f7
    bc1t no_real_solutions

    # Calculating roots
    sqrt.s $f8, $f6       # sqrt(discriminante) -> $f8
    neg.s $f9, $f1        # -b -> $f9
    add.s $f10, $f9, $f8  # -b + sqrt(discriminante) -> $f10
    sub.s $f11, $f9, $f8  # -b - sqrt(discriminante) -> $f11
    li.s $f12, 2.0
    mul.s $f12, $f12, $f0 # 2a -> $f12
    div.s $f13, $f10, $f12  # x1 -> $f13
    div.s $f14, $f11, $f12  # x2 -> $f14

    # Print x1
    li $v0, 4
    la $a0, message_x1
    syscall
    li $v0, 2
    mov.s $f12, $f13
    syscall

    # Print x2
    li $v0, 4
    la $a0, message_x2
    syscall
    li $v0, 2
    mov.s $f12, $f14
    syscall

    j exit

no_real_solutions:
    li $v0, 4
    la $a0, message_no_real
    syscall

exit:
    li $v0, 10
    syscall
