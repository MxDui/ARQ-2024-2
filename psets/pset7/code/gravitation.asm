.data

#Las constantes fueron obtenidas de https://nssdc.gsfc.nasa.gov/planetary/factsheet/moonfact.html
G: .float 6.674e-11     # Constante gravitacional en unidades de m^3 kg^-1 s^-2
m1: .float 5.972e24     # Masa de la Tierra en kilogramos
m2: .float 7.348e22     # Masa de la Luna en kilogramos
r: .float 3.844e8       # Distancia entre la Tierra y la Luna en metros
result_message: .asciiz "La fuerza gravitacional es: "  # Mensaje para mostrar el resultado

.text
.globl main

main:
    lwc1 $f0, G           # Carga la constante gravitacional G en el registro $f0
    lwc1 $f1, m1          # Carga la masa de la Tierra m1 en el registro $f1
    lwc1 $f2, m2          # Carga la masa de la Luna m2 en el registro $f2
    lwc1 $f3, r           # Carga la distancia entre la Tierra y la Luna r en el registro $f3
    mul.s $f4, $f0, $f1   # Multiplica G * m1 y almacena el resultado en $f4
    mul.s $f4, $f4, $f2   # Multiplica el resultado anterior (G * m1) por m2, almacenando en $f4
    mul.s $f5, $f3, $f3   # Calcula el cuadrado de la distancia, r^2, y lo almacena en $f5
    div.s $f6, $f4, $f5   # Divide el producto (G * m1 * m2) entre r^2 para obtener la fuerza gravitacional

    # Mostrar resultado
    li $v0, 4             # Establece el código de operación para imprimir una cadena
    la $a0, result_message  # Carga la dirección de memoria de result_message en $a0
    syscall               # Realiza la llamada al sistema para imprimir la cadena "La fuerza gravitacional es: "
    li $v0, 2             # Establece el código de operación para imprimir un número flotante
    mov.s $f12, $f6       # Mueve el resultado de la fuerza gravitacional a $f12, preparándolo para la impresión
    syscall               # Realiza la llamada al sistema para imprimir el número flotante

    # Salir del programa
    li $v0, 10            # Establece el código de operación para terminar la ejecución del programa
    syscall               # Realiza la llamada al sistema para salir del programa

# El resultado fue = La fuerza gravitacional es: 198202170555366375424.00000000

