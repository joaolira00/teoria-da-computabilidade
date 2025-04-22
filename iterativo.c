#include <stdio.h>

int main() {
    int n;
    long long prevNumber = 0, currentNumber = 1, nextNumber = 0;

    printf("Digite o número de termos para a sequência de Fibonacci: ");
    scanf("%d", &n);

    if (n <= 0) {
        printf("Número inválido! Tente novamente.\n");
        return 1;
    }

    if (n == 1) {
        printf("0\n");
        return 0;
    }
    if (n == 2) {
        printf("1\n");
        return 0;
    }

    for (int i = 2; i <= n; i++) {
        nextNumber = prevNumber + currentNumber;
        prevNumber = currentNumber;
        currentNumber = nextNumber;
    }

    printf("%lld\n", currentNumber);
    return 0;
}
