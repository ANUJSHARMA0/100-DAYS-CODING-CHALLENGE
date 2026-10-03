#include <stdio.h>

int main(void)
{
    double celsius;
    double fahrenheit;

    printf("Enter temperature in Celsius: ");
    if (scanf("%lf", &celsius) != 1) {
        printf("Invalid input. Please enter a temperature.\n");
        return 1;
    }

    fahrenheit = (celsius * 9.0 / 5.0) + 32.0;
    printf("%.2f Celsius is %.2f Fahrenheit.\n", celsius, fahrenheit);

    return 0;
}
