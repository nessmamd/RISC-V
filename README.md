# Exercise C: Writing String-handling Functions

## Read This First

This exercise aims to help you practice processing C strings using the `lbu` and `sb` instructions. It's strongly recommended to complete Exercises A and B before attempting this one, as they provide useful examples of system call outputs and C string operations with `lbu` and `sb`.

## What to Do

The files required for this exercise are located in `encm369w23lab04/exC`. Begin by reading `string-funcs.c` to understand its functionality. Build and run an executable to verify if the output matches your expectations.

Next, edit the file `string-funcs.asm` to ensure that the assembly-language definitions of `copycat` and `lab4reverse` match their C definitions. If done correctly, the output from the RARS program should match the output from the C program.

### string-funcs.c

```c
// ENCM 369 Winter 2023 Lab 4 Exercise C

#include <stdio.h>

void copycat(char *dest, const char *src1, const char *src2)
{
  char c;
  while (*src1 != '\0') {
    *dest = *src1;
    dest++;
    src1++;
  }
  do {
    c = *src2;
    *dest = c;
    dest++;
    src2++;
  } while (c != '\0');    
}

void lab4reverse(char *str)
{
  // Reverses the order of characters in a C string.
  int front, back;
  char c;
  back = 0;
  while (str[back] != '\0')
    back++;
  back--;
  front = 0;
  while (back > front) {
    c = str[back];
    str[back] = str[front];
    str[front] = c;
    back--;
    front++;
  }
}

void print_in_quotes(const char *str)
{
  fputc('"', stdout);
  fputs(str, stdout);
  fputc('"', stdout);
  fputc('\n', stdout);
}

char array1[32] = {
  '\0', '*', '*', '*', '*', '*', '*', '*', 
  '*', '*', '*', '*', '*', '*', '*', '*', 
  '*', '*', '*', '*', '*', '*', '*', '*', 
  '*', '*', '*', '*', '*', '*', '*', '*', 
};

char array2[ ] = "X";
char array3[ ] = "YZ";
char array4[ ] = "123456";
char array5[ ] = "789abcdef";

int main(void)
{
  copycat(array1, "", "");  
  fputs("After 1st call to copycat, array1 has ", stdout);
  print_in_quotes(array1);

  copycat(array1, "good", "");  
  fputs("After 2nd call to copycat, array1 has ", stdout);
  print_in_quotes(array1);

  copycat(array1, "", "bye");  
  fputs("After 3rd call to copycat, array1 has ", stdout);
  print_in_quotes(array1);

  copycat(array1, "good", "bye");  
  fputs("After 4th call to copycat, array1 has ", stdout);
  print_in_quotes(array1);

  lab4reverse(array2);
  fputs("After use of lab4reverse, array2 has ", stdout);
  print_in_quotes(array2);

  lab4reverse(array3);
  fputs("After use of lab4reverse, array3 has ", stdout);
  print_in_quotes(array3);

  lab4reverse(array4);
  fputs("After use of lab4reverse, array4 has ", stdout);
  print_in_quotes(array4);

  lab4reverse(array5);
  fputs("After of use of lab4reverse, array5 has ", stdout);
  print_in_quotes(array5);

  return 0;
}