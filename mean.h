#ifndef MEAN_CALCULATIONS_H  
#define MEAN_CALCULATIONS_H

/**
 * Calculates the arithmetic mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The arithmetic mean of the array.
 */
float media_aritmetica(float datos[], int n);

/**
 * Calculates the harmonic mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The harmonic mean of the array.
 */
float media_armonica(float datos[], int n);

/**
 * Calculates the geometric mean of an array of floating-point numbers.
 * 
 * @param datos The array of floating-point numbers.
 * @param n The number of elements in the array.
 * @return The geometric mean of the array.
 */
float media_geometrica(float datos[], int n);

#endif 
