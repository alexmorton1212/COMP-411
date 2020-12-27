/* Example: matrices represented by 2-dimensional arrays */

#include <stdio.h>

int main()
{
  int A[3][3];    // matrix A
  int B[3][3];    // matrix B
  int C[3][3];    // matrix to store their sum

  int i, j, n;

  // add your code below


  printf ("Please enter 9 values for matrix A:\n");

  for (i = 0; i < 3; i++) {

    for (j = 0; j < 3; j++) {

      scanf ("%d", &A[i][j]);
    }
  }

  printf ("Please enter 9 values for matrix B:\n");

  for (i = 0; i < 3; i++) {

    for (j = 0; j < 3; j++) {

      scanf ("%d", &B[i][j]);
    }
  }

  printf ("C = B + A =\n");

  for (i = 0; i < 3; i++) {

    for (j = 0; j < 3; j++) {

      C[i][j] = A[i][j] + B[i][j];
    }
  }

  printf ("%10d%10d%10d\n", C[0][0], C[0][1], C[0][2]);
  printf ("%10d%10d%10d\n", C[1][0], C[1][1], C[1][2]);
  printf ("%10d%10d%10d\n", C[2][0], C[2][1], C[2][2]);

}
