#include <stdio.h>

void main() {

    int n, i;
    int a, b, c, d, e, f;

    printf ("Enter six integers:\n");

      for (i = 0; i <6; i++) {

        scanf ("%d", &n);

        if (i == 0) {
            a = n;
        }

        if (i == 1) {
            b = n;
        }

        if (i == 2) {
            c = n;
        }

        if (i == 3) {
            d = n;
        }

        if (i == 4) {
            e = n;
        }

        if (i == 5) {
            f = n;
        }

      }

    printf ("1234567890bb1234567890\n");
    printf ("%10d%12d \n", a, b);
    printf ("%10d%12d \n", c, d);
    printf ("%10d%12d \n", e, f);
}

