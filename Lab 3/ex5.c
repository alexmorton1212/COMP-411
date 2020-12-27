#include <stdio.h>
#include <string.h>
#include <ctype.h>
#define MAX_BUF 1024

int main () {

  char buf[MAX_BUF], lower;
  int length, i;
  // other stuff


  do {

    fgets (buf, MAX_BUF, stdin);

    length = strlen(buf);

    if (buf[length - 1] == '\n') {
        buf[length - 1] = '\0';
    }

    for (i = 0; i < length; i++) {

      lower = tolower(buf[i]);

      if (lower == 'e') {
	buf[i] = '3';
      }

      if (lower == 'i') {
	buf[i] = '1';
      }

      if (lower == 'o') {
	buf[i] = '0';
      }

      if (lower == 's') {
	buf[i] = '5';
      }

    }

    if (length > 1) {
      printf ("%s\n", buf);
    }

  } while (length > 1);

}
