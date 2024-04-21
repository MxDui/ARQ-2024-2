def calcular_serie(m):
    suma = 0.0
    for n in range(m + 1):
        suma += ((-1)**n) / (2*n + 1)
    return 4 * suma

# Prueba con diferentes valores de m
for m in [10, 1000, 10000]:
    resultado = calcular_serie(m)
    print(f"Resultado para m={m}: {resultado}")
