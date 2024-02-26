#include <math.h>

/**
 * Calculates the arithmetic mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The arithmetic mean of the array.
 */
float media_aritmetica(float datos[], int n) {
    float sum = 0;
    for (int i = 0; i < n; i++) {
        sum += datos[i];
    }
    return sum / n;
}

/**
 * Calculates the harmonic mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The harmonic mean of the array.
 */
float media_armonica(float datos[], int n) {
    float sum = 0;
    for (int i = 0; i < n; i++) {
        sum += 1 / datos[i];
    }
    return n / sum;
}

/**
 * Calculates the geometric mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The geometric mean of the array.
 */
float media_geometrica(float datos[], int n) {
    float product = 1;
    for (int i = 0; i < n; i++) {
        product *= datos[i];
    }
    return pow(product, 1.0 / n);
}
