#include <stdio.h>
#include <conio.h>
int main()
{
    // scanf() function is used to read the input from the user.
    float num1, num2;
    scanf("%f %f", &num1, &num2);
    printf("The numbers entered are: %.2f and %.2f", num1, num2);
    return 0;
}