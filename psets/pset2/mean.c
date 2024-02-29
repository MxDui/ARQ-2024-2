#include <math.h>

/**
 * Calcula la media aritmética de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media aritmética del array.
 */
float media_aritmetica(float datos[], int n) {
    float sum = 0;
    for (int i = 0; i < n; i++) {
        sum += datos[i];
    }
    return sum / n;
}

/**
 * Calcula la media armónica de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media armónica del array si no hay valores de cero, -1 si hay.
 */
float media_armonica(float datos[], int n) {
    float sum = 0;
    for (int i = 0; i < n; i++) {
        if (datos[i] == 0) {
            return -1; 
        }
        sum += 1 / datos[i];
    }
    return n / sum;
}

/**
 * Calcula la media geométrica de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media geométrica del array si no hay valores negativos, -1 si hay.
 */
float media_geometrica(float datos[], int n) {
    float product = 1;
    for (int i = 0; i < n; i++) {
        if (datos[i] < 0) {
            return -1; 
        }
        product *= datos[i];
    }
    return pow(product, 1.0 / n);
}
