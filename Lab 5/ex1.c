#include<stdio.h>
#include<stdlib.h>
#include <ctype.h>

#define true 1
#define false 0

#define MAX 100

int maze[100][100];             // 100x100 is the maximum size needed
int wasHere[100][100];
int correctPath[100][100];
int width, height;
int startX, startY, endX, endY;

int recursiveSolve(int x, int y);

int main() {

  int x, y;

  scanf("%d%d", &width, &height);

  // This is needed to "eat" the newline after height
  // before the actual maze entries begin on the next line

  scanf("\n");

  /* NOTE:  maze[y][x] will refer to the (x,y) element of the maze,
	   i.e., y-th row and x-th column in the maze.
     The row is typically the first index in a 2D array because
     reading and writing is done row-wise.  This is called
     "row-major" order.

     Also note that although we have declared the maze to be 100x100,
     that is the maximum size we need.  The actual entries in the
     maze will be height * width.
  */

  char tempchar;

  for(int y = 0; y < height; y++) {

    for(int x = 0; x < width; x++) {

      scanf("%c", &tempchar);

      maze[y][x] = tempchar;

      correctPath[y][x] = 0;
      wasHere[y][x] = false;

      // Check for 'S' and 'F' here and use that to
      // set values of startX, startY, endX and endY

      if (tempchar == 'S') {
	startX = x;
	startY = y;
      }

      if (tempchar == 'F') {
	endX = x;
	endY = y;
      }

    }

     // This is used to "eat" the newline

     scanf("%c", &tempchar);
  }

  recursiveSolve(startX, startY);

    for (int y = 0; y < height; y++) {

	for (int x = 0; x < width; x++) {

	    if (x == startX && y == startY) {
		printf("S");

	    } else {

		if (x == endX && y == endY) {
		    printf("F");

		} else {

		    if (maze[y][x] == '*') {
		        printf("*");

		    } else {

			if (correctPath[y][x] == 1) {
		            printf(".");

			} else {
			    printf(" ");
	    		}
		    }
		}
	    }
	}

	printf("\n");
    }
}


int recursiveSolve(int x, int y) {

   // If you reached the end

   if (x == endX && y == endY) {
	return true;
   }

   // If you are on a wall or already were here

   if (maze[y][x] == '*' || wasHere[y][x]) {
	return false;
   }

   // Ensures it does not go back to same place

   wasHere[y][x] = true;


  // Checks if not on left edge
  // Calls method one to the left

  if (x != 0) {

	if (recursiveSolve(x-1, y)) {
            correctPath[y][x] = 1;
            return true;
        }
   }

  // Checks if not on right edge
  // and Calls method one to the right

   if (x != width - 1)  {

	if (recursiveSolve(x+1, y)) {
            correctPath[y][x] = 1;
            return true;
        }
   }

  // Checks if not on top edge
  // and Calls method one up

   if (y != 0) {

        if (recursiveSolve(x, y-1)) {
            correctPath[y][x] = 1;
            return true;
        }
   }

  // Checks if not on bottom edge
  // and Calls method one down

   if (y != height - 1) {

        if (recursiveSolve(x, y+1)) {
            correctPath[y][x] = 1;
            return true;
        }
   }

   return false;
}


