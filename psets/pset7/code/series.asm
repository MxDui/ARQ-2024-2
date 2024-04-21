.data
m: .word 10000  # Cambiar el valor para diferentes pruebas

.text
main:
    li $t0, 0           # n = 0
    lwc1 $f2, m         # Carga m en $f2
    li.s $f12, 4.0      # Factor de multiplicación por 4
    li.s $f0, 0.0       # suma = 0.0

loop:
    mov.s $f4, $f0      # $f4 = suma
    mtc1 $t0, $f6       # Convierte n a punto flotante
    cvt.s.w $f6, $f6
    li.s $f8, 2.0
    mul.s $f6, $f6, $f8 # 2*n
    add.s $f6, $f6, $f1 # 2*n + 1
    div.s $f10, $f14, $f6  # 1 / (2*n + 1)

    # Alternar signos
    div.s $f12, $f12, $f16  # -1^n
    mul.s $f10, $f10, $f12  # (-1)^n / (2*n + 1)
    
    add.s $f0, $f4, $f10    # suma += término actual
    addi $t0, $t0, 1        # n += 1
    c.le.s $f2, $f6         # Comprueba si n <= m
    bc1t loop

    mul.s $f0, $f0, $f12    # Multiplica la suma total por 4
    # Llama a syscall para imprimir $f0 o terminar el programa
    
    li $v0, 10              # Terminar programa
    syscall
