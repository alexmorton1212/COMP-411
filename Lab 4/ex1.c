#include <stdio.h>  /* Need for standard I/O functions */
#include <string.h> /* Need for strlen() */

#define NUM 25   /* number of strings */
#define LEN 1000  /* max length of each string */


/* COMPARE
   compares two strings (character by character)
   uses ASCII values (no need to assign own values to letters)
   returns 0 if strings are exactly the same
   returns -1 if string1 is smaller
   returns +1 if string1 is bigger
*/

int my_compare_strings(char string1[], char string2[]) {

  int length1 = strlen(string1);
  int length2 = strlen(string2);
  int count = 0;

  for (int i = 0; i < LEN; i++) {

	if (string1[i] == '\0' && string2[i] == '\0' && string1[i] == string2[i]) { return 0;}
	if (string1[i] == '\0' && string2[i] != '\0') { return -1;}
	if (string2[i] == '\0' && string1[i] != '\0') { return +1;}
	if (string1[i] == string2[i]) { continue;}
	if (string1[i] < string2[i]) { return -1;}
	if (string1[i] > string2[i]) { return +1;}
  }
}


/* SWAP
   swaps each string's characters (character-by-character)
   be careful of accessing array space that does not exist...
   may get a "stack smashing error" if this happens
*/

void my_swap_strings(char string1[], char string2[]) {

  char temp;

  for (int i = 0; i < LEN; i++) {

	temp = string1[i];
        string1[i] = string2[i];
        string2[i] = temp;
  }
}


/* MAIN
   this where the magic happens :)
   we love bubble sorting :)
*/

int main()
{
  char Strings[NUM][LEN];
  int length[NUM];

  printf("Please enter %d strings, one per line:\n", NUM);

  // reads in each string (up to NUM)
  // assigns each strings length to an array

    for (int i = 0; i < NUM; i++) {

	fgets(Strings[i], LEN, stdin);

	    for (int j = 0; j < LEN; j++) {

		if (Strings[i][j] == '\n') {
		    Strings[i][j] = '\0';
		}
	    }

	length[i] = strlen(Strings[i]);
    }

// prints ENTERED STRINGS

  puts("\nHere are the strings in the order you entered:");

    for (int i = 0; i < NUM; i++) {

	for (int j = 0; j < length[i]; j++) {
	    printf ("%c", Strings[i][j]);
        }

	printf ("\n");
    }


// prints strings in ALHPABETICAL ORDER

  puts("\nIn alphabetical order, the strings are:");


  /* BUBBLE SORT
     pushes "smallest" string to the front
     subsequent strings are ordered in the same way...
     until longest string is left at the end
  */

  for (int i = 0; i < NUM; i++) {

	for (int j = 0; j < NUM; j++) {

	    if (i == j) {
		continue;
	    }

	    if (my_compare_strings(Strings[i], Strings[j]) == -1) {
		my_swap_strings(Strings[i], Strings[j]);

	    } else {
		continue;
	    }
	}
    }

  for (int i = 0; i < NUM; i++) {

	printf ("%s\n", Strings[i]);
  }
}



// TEEEEESTTSSS for SWAP and COMPARE :)


/* Quick test for comparing strings

  if (my_compare_strings(Strings[0], Strings[1]) == -1) {
        printf ("the first word should have been smaller\n");
  } else if (my_compare_strings(Strings[0], Strings[1]) == +1) {
        printf ("the second word should have been smaller\n");
  } else if (my_compare_strings(Strings[0], Strings[1]) == 0) {
        printf ("the words are the same\n");
  }
*/


/* Quick test for swapping strings

printf ("Swap test\n");

  printf ("%s\n", Strings[0]);
  printf ("%s\n", Strings[1]);
  my_swap_strings(Strings[0], Strings[1]);
  printf ("%s\n", Strings[0]);
  printf ("%s\n", Strings[1]);
*/
