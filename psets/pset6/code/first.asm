.data
# No hay variables declaradas en la sección de datos para este programa.

.text
.globl main

main:
    li $t1, 0x1234  # Carga el valor inmediato 0x1234 en el registro $t1.
    add $t2, $t1, $zero  # Copia el contenido de $t1 a $t2 sumando cero.

    # Fin del programa, no se necesitan más instrucciones.
    li $v0, 10     # Carga el código del syscall para salir (exit) en $v0.
    syscall        # Realiza un syscall para terminar el programa.
