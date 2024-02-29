#include <stdio.h>
#include <stdlib.h>
#include "mean.h"

int main(int argc, char *argv[]) {
    
    if (argc < 3) {
        printf("Uso: %s <A|H|G> <dato1> <dato2> ...\n", argv[0]);
        return 1;
    }

    int n = argc - 2;
    float datos[n];
    char* finalPtr;

    for (int i = 0; i < n; i++) {
        datos[i] = strtod(argv[i + 2], &finalPtr);

        if (*finalPtr != '\0' || finalPtr == argv[i + 2]) {
            printf("Error: '%s' no es un número válido.\n", argv[i + 2]);
            return 1;
        }
    }

    float result;
    switch (argv[1][0]) {
        case 'A':
            result = media_aritmetica(datos, n);
            printf("La media aritmética es: %f\n", result);
            break;
        case 'H':
            result = media_armonica(datos, n);
            if (result == -1) {
                printf("Error: La media armónica es indefinida debido a un valor de cero.\n");
            } else {
                printf("La media armónica es: %f\n", result);
            }
            break;
        case 'G':
            result = media_geometrica(datos, n);
            if (result == -1) {
                printf("Error: La media geométrica es indefinida debido a un valor negativo.\n");
            } else {
                printf("La media geométrica es: %f\n", result);
            }
            break;
        default:
            printf("Operación no reconocida: %s\n", argv[1]);
            return 1;
    }

    return 0;
}
