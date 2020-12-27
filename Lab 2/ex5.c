#include <stdio.h>

void main() {

    int height, width, i, j, check;

    check = 1;

    while (check != 0) {

	printf ("Please enter width and height:\n");

	scanf ("%d", &width);

	    if (width == 0) {
                printf ("End\n");
                check = 0;
                break;
            }

	    if (width < 0 || width > 100) {
		printf ("Width is not in the range 1-100\n");
	    }

	scanf ("%d", &height);

	    if (height < 1 || height > 100) {
                printf ("Height is not in the range 1-100\n");
            }

    for (i = 0; i < height; i++) {

	for (j = 0; j < width; j++) {

	    if (i == 0 || i == height - 1) {

		if (j == 0 || j == width - 1) {
		    printf ("+");
		} else {
		    printf ("-");
		}

	    } else {

		if (j > 0 || j < height) {

		    if (j == 0 || j == width - 1) {
			printf ("|");
		    } else {
			printf ("~");
		    }
		}
	    }
	}

	printf ("\n");
    }

    }
}
