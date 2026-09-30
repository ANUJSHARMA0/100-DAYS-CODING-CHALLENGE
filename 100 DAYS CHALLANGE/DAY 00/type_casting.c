#include <stdio.h>
#include <conio.h>
int main()
{
    // type casting
    int a = 10;
    int c = 10;
    float b = (float)a;            // explicit type casting
    float d = (float)a / (float)c; // implicit type casting
    printf("Value of a: %d\n", a);
    printf("Value of b: %.2f\n", b);
    return 0;
}