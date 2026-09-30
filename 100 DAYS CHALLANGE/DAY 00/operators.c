#include <stdio.h>
#include <conio.h>
int assignment_operators()
{
    // assignment operators
    int a = 10; // assignment operator
    a += 5;     // addition assignment operator
    a -= 3;     // subtraction assignment operator
    a *= 2;     // multiplication assignment operator
    a /= 4;     // division assignment operator
    a %= 3;     // modulus assignment operator
    printf("Final value of a: %d\n", a);
    return 0;
}

int comparison_operators()
{
    // comparison operators or relational operators
    int x = 10, y = 20;
    printf("x == y: %d\n", x == y); // equal to
    printf("x != y: %d\n", x != y); // not equal to
    printf("x > y: %d\n", x > y);   // greater than
    printf("x < y: %d\n", x < y);   // less than
    printf("x >= y: %d\n", x >= y); // greater than or equal to
    printf("x <= y: %d\n", x <= y); // less than or equal to
    return 0;
}

int logical_operators()
{
    // logical operators
    int p = 1, q = 0;
    printf("p && q: %d\n", p && q); // logical AND
    printf("p || q: %d\n", p || q); // logical OR
    printf("!p: %d\n", !p);         // logical NOT
    return 0;
}

int bitwise_operators()
{
    // bitwise operators
    int m = 5, n = 3;
    printf("m & n: %d\n", m & n);   // bitwise AND
    printf("m | n: %d\n", m | n);   // bitwise OR
    printf("m ^ n: %d\n", m ^ n);   // bitwise XOR
    printf("~m: %d\n", ~m);         // bitwise NOT
    printf("m << 1: %d\n", m << 1); // left shift
    printf("m >> 1: %d\n", m >> 1); // right shift
    return 0;
}

int increment_decrement_operators()
{
    // increment and decrement operators
    int num = 5;
    printf("num++: %d\n", num++); // post-increment
    printf("++num: %d\n", ++num); // pre-increment
    printf("num--: %d\n", num--); // post-decrement
    printf("--num: %d\n", --num); // pre-decrement
    return 0;
}

int conditional_operator()
{
    // conditional operator (ternary operator)
    int age = 18;
    const char *result = (age >= 18) ? "Adult" : "Minor";
    printf("You are an %s.\n", result);
    return 0;
}

int sizeof_operator()
{
    // sizeof operator
    int arr[10];
    printf("Size of int: %zu bytes\n", sizeof(int));
    printf("Size of float: %zu bytes\n", sizeof(float));
    printf("Size of char: %zu bytes\n", sizeof(char));
    printf("Size of array: %zu bytes\n", sizeof(arr));
    return 0;
}

int comma_operator()
{
    // comma operator
    int a = 1, b = 2, c;
    c = (a++, b++); // evaluates a++ and b++, returns the value of b++
    printf("Value of c: %d\n", c);
    printf("Value of a: %d\n", a);
    printf("Value of b: %d\n", b);
    return 0;
}

int pointer_operators()
{
    // pointer operators
    int x = 10;
    int *ptr = &x;                             // pointer to x
    printf("Value of x: %d\n", *ptr);          // dereferencing pointer
    printf("Address of x: %p\n", (void *)ptr); // address of x
    return 0;
}

int member_access_operators()
{
    // member access operators
    struct Point
    {
        int x;
        int y;
    };
    struct Point p1 = {10, 20};
    struct Point *ptr = &p1;
    printf("Point coordinates: (%d, %d)\n", p1.x, p1.y);                 // using dot operator
    printf("Point coordinates via pointer: (%d, %d)\n", ptr->x, ptr->y); // using arrow operator
    return 0;
}

int main()
{
    assignment_operators();
    comparison_operators();
    logical_operators();
    bitwise_operators();
    increment_decrement_operators();
    conditional_operator();
    sizeof_operator();
    comma_operator();
    pointer_operators();
    member_access_operators();
    return 0;
}
