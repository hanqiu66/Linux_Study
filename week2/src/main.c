#include <stdio.h>
/* 函数原型声明 */
int foo(void);
int bar(void);
int main(void)
{
printf("Hello from main!\n");
printf("foo() returns %d\n", foo());
printf("bar() returns %d\n", bar());
return 0;
}
