// Program that takes 10 floating numbers and gives info (specified by user)

#include <stdio.h>

void main() {

    double n, sum, min, max, product;
    int i;

    printf ("Enter 10 floating-point numbers:\n");

    for (i = 0; i < 10; i++) {

	scanf ("%lf", &n);

	if (i == 0) {

	    max = n, min = n, product = n, sum = n;
	}

	if (i > 0) {

	    if (n < min) {
		min = n;
	    }

	    if (n > max) {
		max = n;
	    }

	   product *=n;
	   sum +=n;
	}
    }

    printf ("Sum is %.5lf\n", sum);
    printf ("Min is %.5lf\n", min);
    printf ("Max is %.5lf\n", max);
    printf ("Product is %.5lf\n", product);
}

