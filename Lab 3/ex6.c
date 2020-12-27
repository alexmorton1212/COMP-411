#include <stdio.h>
#include <string.h>
#include <ctype.h>


int main () {

  int n, k, x = 1;

  int NchooseK (int n, int k) {

    if (k == 0) {
      return 1;
    }

    if (n == k) {
      return 1;
    }

    return  NchooseK(n-1, k-1) + NchooseK(n-1, k);
  }

  do {

    printf("Enter two integers (for n and k) separated by space:\n");

    scanf("%d %d", &n, &k);

    if (n == 0 && k == 0) {
      x = 0;
    }

    printf("%d\n", NchooseK(n, k));

  } while (x == 1);


}

