#ifndef MEAN_CALCULATIONS_H  
#define MEAN_CALCULATIONS_H

/**
 * Calcula la media aritmética de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media aritmética del array.
 */
float media_aritmetica(float datos[], int n);

/**
 * Calcula la media armónica de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media armónica del array si no hay valores de cero, -1 si hay.
 */
float media_armonica(float datos[], int n);

/**
 * Calcula la media geométrica de un array de números de punto flotante.
 * 
 * @param datos El array de números de punto flotante.
 * @param n El número de elementos en el array.
 * @return La media geométrica del array si no hay valores negativos, -1 si hay.
 */
float media_geometrica(float datos[], int n);

#endif 
