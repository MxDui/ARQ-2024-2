#include <stdio.h>
#include <mean.h>   
#include <stdlib.h>

int main(int argc, char *argv[]) {
    
    if (argc < 3) {
        printf("Uso: %s <A|H|G> <dato1> <dato2> ...\n", argv[0]);
        return 1;
    }

    int n = argc - 2;

    float datos[n];

    for (int i = 0; i < n; i++) {
        datos[i] = atof(argv[i + 2]);
    }

    switch (argv[1][0]) {
        case 'A':
            printf("La media aritmética es: %f\n", media_aritmetica(datos, n));
            break;
        case 'H':
            printf("La media armónica es: %f\n", media_armonica(datos, n));
            break;
        case 'G':
            printf("La media geométrica es: %f\n", media_geometrica(datos, n));
            break;
        default:
            printf("Opción no válida\n");
            return 1;
    }

    return 0;
}
