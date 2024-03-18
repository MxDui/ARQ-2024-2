# Cómo Compilar y Usar la Herramienta

Este documento proporciona instrucciones sobre cómo compilar y utilizar una herramienta de línea de comandos (CLI) diseñada para realizar practica4 lógicas y aritméticas en números enteros sin signo representados en binario.

## Requisitos Previos

Para compilar y ejecutar esta herramienta, necesitarás:

- Un compilador de C, como GCC o Clang.
- Un entorno de terminal o línea de comandos.

## Compilación

1. Abre tu terminal o línea de comandos.
2. Navega al directorio donde has guardado el archivo de código fuente. Si no has cambiado el nombre del archivo, debería llamarse `main.c` o algo similar.
3. Utiliza el siguiente comando para compilar el código:

```bash
gcc -o practica4 main.c
```

Este comando compila el archivo `main.c` y genera un ejecutable llamado `practica4`. Puedes cambiar `practica4` por el nombre que prefieras para el archivo ejecutable.

## Uso

Una vez compilado, puedes ejecutar la herramienta utilizando la siguiente sintaxis:

```bash
./practica4 <operacion> <operando1> <operando2>
```

- `<operacion>`: Una cadena binaria de 3 bits que representa la operación a realizar. Las practica4 disponibles son:
  - `000`: AND lógico
  - `001`: OR lógico
  - `010`: XOR lógico
  - `011`: NOT lógico (solo se considera `<operando1>`)
  - `100`: Suma
  - `101`: Resta
  - `110`: Multiplicación
  - `111`: División
- `<operando1>` y `<operando2>`: Cadenas binarias de 32 bits que representan los operandos para la operación. Nota que para la operación NOT, `<operando2>` se ignora.

### Ejemplos

- Realizar una operación AND entre dos números:

```bash
./practica4 000 00000000000000000000000000000001 00000000000000000000000000000001
```

- Realizar una suma entre dos números:

```bash
./practica4 100 00000000000000000000000000000001 00000000000000000000000000000001
```

Recuerda reemplazar los valores de `<operacion>`, `<operando1>` y `<operando2>` con los correspondientes a tu caso de uso.

## Notas Adicionales

- Asegúrate de que los operandos y la operación estén correctamente representados en binario y que cumplan con las longitudes especificadas (3 bits para la operación, 32 bits para los operandos).
- Para divisiones, evita dividir por cero, ya que esto puede llevar a un comportamiento indefinido.
- El resultado de las practica4 se muestra en formato decimal.

Siguiendo estas instrucciones, podrás compilar y utilizar la herramienta para realizar practica4 lógicas y aritméticas en números representados en formato binario.
