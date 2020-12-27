#include <stdio.h>
#include <string.h>

char animals[20][15];
char lyrics[20][60];
int number;
int count;

void nurseryrhyme(int current) {

  printf("%*s", current, "");

  if (current == 0) {

	if (count == 0) {
 	    printf("There was an old lady who swallowed a %s", animals[current]);
	    printf(";\n");
	}

	if (count == 1) {
	    printf("I don't know why she swallowed a %s - %s", animals[current], lyrics[current]);
	    printf("\n");
	}
  }

  if (current > 0) {

	if (count == 0) {
	    printf("She swallowed the %s to catch the %s", animals[current-1], animals[current]);
	    printf(";\n");
        }

	if (count == 1) {
            printf("I don't know why she swallowed a %s - %s", animals[current], lyrics[current]);
	    printf("\n");
	    nurseryrhyme(current - 1);
        }
  }

  if (current < number - 1 && count == 0) {
	nurseryrhyme(current + 1);
  }

  if (current == number - 1 && count == 0) {
	count = 1;
	printf("%*s", current, "");
 	printf("I don't know why she swallowed a %s - %s", animals[current], lyrics[current]);
	printf("\n");
 	nurseryrhyme(current - 1);
  }
}


int main() {

  int i = 0;

  while (1) {

    fgets(animals[i], 15, stdin);

    if (strcmp(animals[i], "END\n") == 0) {
	break;
    }

    int alength = strlen(animals[i]);
    animals[i][alength - 1] = '\0';

    fgets(lyrics[i], 60, stdin);

    int llength = strlen(lyrics[i]);
    lyrics[i][llength - 1] = '\0';

    i++;
  }

  number = i;
  count = 0;

  nurseryrhyme(0);
}
