#include <stdio.h>

void recursive_Fibonacci(int count, int n, long long a, long long b) {
    long long nextNumber = a + b;
    if (count == n) {
        printf("%lld", nextNumber);
        return;
    }
    recursive_Fibonacci(count + 1, n, b, nextNumber);
}

int main() {
    int n;
    long long prevNumber = 0, currentNumber = 1;

    printf("Digite o valor de n para a sequência de Fibonacci: ");
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

    recursive_Fibonacci(2, n, prevNumber, currentNumber);
    printf("\n");
    return 0;
}
