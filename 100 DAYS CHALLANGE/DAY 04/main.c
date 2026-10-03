#include <stdio.h>

int main(void)
{
    int choice;
    double firstNumber;
    double secondNumber;

    printf("Calculator\n");
    printf("1. Addition\n");
    printf("2. Subtraction\n");
    printf("3. Division\n");
    printf("4. Multiplication\n");
    printf("Choose an operation (1-4): ");

    if (scanf("%d", &choice) != 1) {
        printf("Invalid input. Please enter a number from 1 to 4.\n");
        return 1;
    }

    if (choice < 1 || choice > 4) {
        printf("Invalid choice. Please choose a number from 1 to 4.\n");
        return 1;
    }

    printf("Enter two numbers: ");
    if (scanf("%lf %lf", &firstNumber, &secondNumber) != 2) {
        printf("Invalid input. Please enter two numbers.\n");
        return 1;
    }

    switch (choice) {
        case 1:
            printf("Result: %g\n", firstNumber + secondNumber);
            break;
        case 2:
            printf("Result: %g\n", firstNumber - secondNumber);
            break;
        case 3:
            if (secondNumber == 0.0) {
                printf("Error: division by zero is not allowed.\n");
                return 1;
            }
            printf("Result: %g\n", firstNumber / secondNumber);
            break;
        case 4:
            printf("Result: %g\n", firstNumber * secondNumber);
            break;
    }

    return 0;
}