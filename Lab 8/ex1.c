#include<stdio.h>

int NchooseK(int n, int k);

int main() {

  int n, k, result, x = 0;

  while (x == 0) {

      scanf("%d", &n);

      if (n == 0) {
	  x = 1;
	  break;
      }

      scanf("%d", &k);
      result = NchooseK(n, k);
      printf("%d\n", result);

  }
}



int NchooseK(int n, int k) {

    if (k == 0) {
      return 1;
    }

    return ((n * NchooseK(n-1, k-1))/k);
}
