// Program that gives ordinal numbers up to 20 (specified by user)

#include <stdio.h>

int main()
{

  int n;
  int i;

  printf ("Enter a number from 1 to 20:\n");
  scanf ("%d", &n);

  // error if input is not in the range

  if (n > 20 || n < 1) {

    printf ("Number is not in the range from 1 to 20\n");

  // if number is in the range

  } else {

    printf ("Here are the first %d ordinal numbers:\n", n);

    for (i = 1; i <= n; i++) {

      if (i == 1) {
	 printf ("1st\n");
      }
      if (i == 2) {
       	printf ("2nd\n");
      }
      if (i == 3) {
	printf ("3rd\n");
      }
      if (i > 3) {
	printf ("%dth\n", i);
      }

    }

  }
  return 0;
}
