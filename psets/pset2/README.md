# Cómo compilar y ejecutar el programa

Para compilar el programa, sigue estos pasos:

1. Abre una terminal.
2. Navega hasta el directorio donde se encuentran los archivos del programa.
3. Ejecuta el siguiente comando:

```bash
gcc -I "./" -o medias main.c ./mean.c -lm
```

Para ejecutar el programa, sigue estos pasos:

1. Abre una terminal.
2. Navega hasta el directorio donde se encuentran los archivos del programa.
3. Ejecuta el siguiente comando:

```bash
./medias <A|H|G> <dato1> <dato2> ...
```

Donde `<A|H|G>` es el tipo de media que se desea calcular y `<dato1> <dato2> ...` son los datos para calcular la media.

Por ejemplo, para calcular la media aritmética de los números 1, 2 y 3, se ejecutaría el siguiente comando:

```bash
./medias A 1 2 3
```
