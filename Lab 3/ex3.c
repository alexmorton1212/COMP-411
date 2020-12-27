/* Example: analysis of text */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX], palin[MAX];
  char alttext[MAX], altpalin[MAX];
  int i, p, j=0, k=0;
  int lowercase, uppercase, digits, other;
  int length, plength;
  int altlength, altplength;

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

  /* Gives strings that ignore whitespaces and punctuation */

  for (i = 0; i < strlen(text); i++) {

    if (isalpha(text[i])) {
      alttext[j] = tolower(text[i]);
      j++;
    }

    if (ispunct(text[i]) != 0 && isspace(text[i]) != 0) {

      alttext[j] = text[i];
      j++;
    }
  }

  for (i = 0; i < strlen(text); i++) {

    if (isalpha(palin[i])) {
      altpalin[k] = tolower(palin[i]);
      k++;
    }

    if (ispunct(palin[i]) != 0 && isspace(palin[i]) != 0) {

      altpalin[k] = palin[i];
      k++;
    }
  }



  altlength = strlen(alttext);
  altplength = strlen(altpalin);

  /* Results: Checks for palindrome */

  printf("Your input in reverse is:\n");
  printf("%s\n", palin);

  for (i = 0; i < altlength - 2; i++) {

    if (alttext[i] != altpalin[i]) {
      p = 1;
    }
  }

  if (p  == 0) {
    printf ("Found a palindrome!\n");
  }

}

