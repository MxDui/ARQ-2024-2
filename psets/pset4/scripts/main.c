#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BITS 32 // Define la cantidad de bits para los operandos

/*
 * Función para convertir una cadena binaria a un entero sin signo.
 * @param bin Puntero a la cadena de caracteres que representa el número binario.
 * @return El valor entero sin signo correspondiente a la cadena binaria.
 */
unsigned int bin_to_int(char *bin) {
    unsigned int num = 0; // Inicializa el resultado a 0.
    int len = strlen(bin); // Obtiene la longitud de la cadena binaria.
    for (int i = 0; i < len; i++) {
        num = (num << 1) + (bin[i] - '0'); // Convierte cada carácter a su valor binario y lo suma al resultado.
    }
    return num; // Devuelve el entero convertido.
}

/*
 * Función para realizar operaciones lógicas entre dos números.
 * @param a Primer operando.
 * @param b Segundo operando.
 * @param op Código de operación (0 para AND, 1 para OR, 2 para XOR, 3 para NOT).
 * @return El resultado de la operación lógica.
 */
unsigned int logica(unsigned int a, unsigned int b, unsigned int op) {
    switch (op) {
        case 0: return a & b; // Operación AND
        case 1: return a | b; // Operación OR
        case 2: return a ^ b; // Operación XOR
        case 3: return ~a;    // Operación NOT
        default: return 0; // Devuelve 0 si la operación no es válida.
    }
}

/*
 * Función para realizar operaciones aritméticas entre dos números.
 * @param a Primer operando.
 * @param b Segundo operando.
 * @param op Código de operación (0 para suma, 1 para resta, 2 para multiplicación, 3 para división).
 * @return El resultado de la operación aritmética.
 */
unsigned int aritmetica(unsigned int a, unsigned int b, unsigned int op) {
    switch (op) {
        case 0: return a + b; // Suma
        case 1: return a - b; // Resta
        case 2: return a * b; // Multiplicación
        case 3: return a / b; // División
        default: return 0; // Devuelve 0 si la operación no es válida.
    }
}

int main(int argc, char *argv[]) {
    if (argc != 4) { // Verifica si se proporcionó el número correcto de argumentos.
        printf("Uso: %s <operacion> <operando1> <operando2>\n", argv[0]); // Imprime el mensaje de uso.
        return 1; // Sale con el código de error 1.
    }

    // Obtiene los strings de operación y operandos de los argumentos del programa.
    char *op_str = argv[1]; 
    char *op1_str = argv[2]; 
    char *op2_str = argv[3]; 

    // Verifica si las longitudes de los strings son válidas.
    if (strlen(op_str) != 3 || strlen(op1_str) != BITS || strlen(op2_str) != BITS) { 
        printf("Longitud de cadenas inválida\n"); // Imprime mensaje de error.
        return 1; // Sale con el código de error 1.
    }

    // Convierte los strings de operación y operandos a enteros sin signo.
    unsigned int operacion = bin_to_int(op_str); 
    unsigned int operando1 = bin_to_int(op1_str); 
    unsigned int operando2 = bin_to_int(op2_str); 

    unsigned int resultado; // Variable para almacenar el resultado.
    // Determina si realizar una operación lógica o aritmética basada en el código de operación.
    if (operacion < 4) {
        resultado = logica(operando1, operando2, operacion); // Realiza operación lógica.
    } else {
        resultado = aritmetica(operando1, operando2, operacion - 4); // Realiza operación aritmética.
    }

    printf("Resultado: %u\n", resultado); // Imprime el resultado.

    return 0; // Sale con el código de éxito 0.
}
