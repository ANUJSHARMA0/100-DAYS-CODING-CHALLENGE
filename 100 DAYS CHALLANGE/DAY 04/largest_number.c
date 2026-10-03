#include <stdio.h>

int main(void)
{
    double firstNumber;
    double secondNumber;

    printf("Enter two numbers: ");
    if (scanf("%lf %lf", &firstNumber, &secondNumber) != 2) {
        printf("Invalid input. Please enter two numbers.\n");
        return 1;
    }

    if (firstNumber > secondNumber) {
        printf("%.2f is the larger number.\n", firstNumber);
    } else if (secondNumber > firstNumber) {
        printf("%.2f is the larger number.\n", secondNumber);
    } else {
        printf("Both numbers are equal.\n");
    }

    return 0;
}
