# Part 1: Programming with Logical Instructions

## Read This First

This exercise focuses on understanding and implementing logical instructions in programming, specifically in the context of C operators. Here are some key points to keep in mind:

Operators Overview: Section C.5 of your textbook provides a comprehensive summary of all C operators, including bitwise shift, bitwise, and logical operators.

Understanding Differences: It's crucial to understand the distinctions between || and |, && and &, and ! and ~. For example, the values obtained from expressions involving these operators may vary significantly.

RISC-V Implementation: In RISC-V assembly, expressions with |, &, or ~ are implemented using instructions like or, ori, and, andi, or xori, as appropriate. However, trying to implement ||, &&, or ! with these instructions would be incorrect.

Shift Operations: In expressions involving << and >>, the data being shifted is on the left, and the shift count is on the right. Understanding how these operations work is essential for manipulating data effectively.

Shift Fill Behavior: While the C standard specifies that a left shift fills with zero bits on the right, the behavior of filling on the left in a right shift of an int may vary across implementations. It can either fill with zero or copies of the sign bit of the data being shifted. This distinction is crucial and may affect program behavior.

### bin_and_bex.c
```c
// bin_and_hex.c
// ENCM 369 Winter 2023 Lab 4 Exercise E


#include <stdio.h>

 
void write_in_hex(char *str, unsigned int word);
// REQUIRES: str points to the beginning of an array of at least 12 elements.
// PROMISES: The base sixteen representation of word, with underscores 
//   separating groups of four hex digits, is written as a string in the array.
// NOTE: The function assumes that int is a 32-bit type.
    

void write_in_binary(char *str, unsigned int word);
// REQUIRES: str points to the beginning of an array of at least 40 elements.
// PROMISES: The base two representation of word, with underscores 
//   separating groups of four bits, is written as a string in the array.
// NOTE: The function assumes that int is a 32-bit type.

 
void test(unsigned int test_value);
// Function to test write_in_binary and write_in_hex.

int main(void)
{
  test(0x76543210);
  test(0x89abcdef);
  test(0);
  test(0xffffffff);
  return 0;
}

void test(unsigned int test_value)
{
  char str[40];
  write_in_hex(str, test_value);
  printf("%s\n", str);
  write_in_binary(str, test_value);
  printf("%s\n\n", str);
}


void write_in_hex(char *str, unsigned int word)
{
  char *digit_list;

  str[0] = '0';
  str[1] = 'x';
  str[6] = '_';
  str[11] = '\0';

  digit_list = "0123456789abcdef";

  str[2] = digit_list[(word >> 28) & 0xf];
  str[3] = digit_list[(word >> 24) & 0xf];
  str[4] = digit_list[(word >> 20) & 0xf];
  str[5] = digit_list[(word >> 16) & 0xf];

  str[7] = digit_list[(word >> 12) & 0xf];
  str[8] = digit_list[(word >> 8) & 0xf];
  str[9] = digit_list[(word >> 4) & 0xf];
  str[10] = digit_list[word & 0xf];
}


void write_in_binary(char *str, unsigned int word)
{
  int bn;                       // bit number within word
  unsigned int mask;            // pattern to isolate a single bit
  int index;                    // index into str
  int digit0, digit1, under;

  bn = 0;
  digit0 = '0';
  digit1 = '1';
  under = '_';

  str[39] = '\0';
  index = 38;
  mask = 1;            // in binary: [ 31 zeros ]_1
  while (1) {
    if ((word & mask) == 0)
      str[index] = digit0;
    else
      str[index] = digit1;
    index--;
    bn++;
    mask = mask << 1;
    if (bn == 32)
      break;
    if ((bn & 3) == 0) {  // if bn is a multiple of 4 ...
      str[index] = under;
      index--;
    }
  }
}

```

# Part 2: Writing String-handling Functions

## Read This First

This exercise aims to help you practice processing C strings using the `lbu` and `sb` instructions. It's strongly recommended to complete Exercises A and B before attempting this one, as they provide useful examples of system call outputs and C string operations with `lbu` and `sb`.


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
