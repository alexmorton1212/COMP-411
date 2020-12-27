/* Example: analysis of text */

#include <stdio.h>
#include <string.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX], c, palin[MAX];
  int i, p;
  int lowercase, uppercase, digits, other;
  int length, plength;

  p = 0;

  puts("Type some text (then ENTER):");

  /* Save typed characters in text[]: */

  fgets(text, MAX, stdin);

  /* Remove the newline character
     Replaced with string terminator */

  length = strlen(text);

  if (text[length - 1] == '\n') {
    text[length - 1] = '\0';
  }

  /* Reverses the input string */

  for (i = 0; i < length; i++) {

    if (i == length - 1) {
      palin[i] = '\0';
    } else {
      palin[i] = text[length - 2 - i];
    }
  }

  printf("Your input in reverse is:\n");
  printf("%s\n", palin);

  /* if i cant use strcmp */

  for (i = 0; i < length - 2; i++) {

    if (text[i] != palin[i]) {
      p = 1;
    }
  }

  if (p  == 0) {
    printf ("Found a palindrome!\n");
  }

}

