#include <stdio.h>

int A[10][10];
int B[10][10];
int C[10][10];

int M, mxprod = 0;

int main() {


  scanf("%d", &M);

  // scans in all values for Matrix A

  for (int i = 0; i < M; i++) {

      for (int j = 0; j < M; j++) {

  	  scanf("%d", &A[i][j]);
      }
  }


  // scans in all values for Matrix B

  for (int i = 0; i < M; i++) {

      for (int j = 0; j < M; j++) {

	  scanf("%d", &B[i][j]);

      }
  }

  // Sets values of Matrix C to matrix product of A and B

  for (int i = 0; i < M; i++) {

      for (int j = 0; j < M; j++) {

	  for (int k = 0; k < M; k++) {

	      mxprod = mxprod + (A[i][k] * B[k][j]);
	  }

	  C[i][j] = mxprod;
	  mxprod = 0;
      }
  }

  // Prints Matric C values with 6 width
  // Adds new line after row is finished

  for (int i = 0; i < M; i++) {

      for (int j = 0; j < M; j++) {

	  printf ("%6d", C[i][j]);

      }

      printf("\n");

  }

}
