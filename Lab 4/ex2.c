#include <stdio.h>  /* Need for standard I/O functions */
#include <string.h> /* Need for strlen() */

#define NUM 25   /* number of strings */
#define LEN 1000  /* max length of each string */


/* MAIN
   this is the real place magic is made @disney :)
*/

int main()
{
  char Strings[NUM][LEN];
  int length[NUM];
  char tempString[LEN];

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



// prints strings in ALPHABETICAL ORDER

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

            if (strcmp(Strings[i], Strings[j]) < 0) {
		strcpy(tempString, Strings[i]);
		strcpy(Strings[i], Strings[j]);
		strcpy(Strings[j], tempString);

            } else {
                continue;
            }
        }
    }

  for (int i = 0; i < NUM; i++) {

        printf ("%s\n", Strings[i]);
  }
}
