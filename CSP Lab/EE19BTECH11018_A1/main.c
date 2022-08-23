#include <stdio.h>
#include <malloc.h>
#include "common_functions.h"

int main()
{
    float x1[] = {0.5377, 1.8339, -2.2588, 0.8622, 0.3188, -1.3077, -0.4336, 0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631, 0.7147, -0.2050, -0.1241, 1.4897, 1.4090, 1.4172};
    float h[] = {0.6715, -1.2075, 0.7172, 1.6302, 0.4889, 1.0347, 0.7269, -0.3034, 0.2939, -0.7873, 0.8884, -1.1471, -1.0689, -0.8095, -2.9443};
    int len_x1 = sizeof(x1) / sizeof(x1[0]);
    int len_h = sizeof(h) / sizeof(h[0]);
    int len_y1 = len_x1 + len_h - 1;
    float *y1 = convolution(x1, len_x1, h, len_h);
    printf("Convolution : ");
    print_array(y1, len_y1);

    float x2[] = {0.5377, 1.8339, -2.2588, 0.8622, 0.3188, -1.3077, -0.4336, 0.3426, 3.5784, 2.7694, -1.3499, 3.0349, 0.7254, -0.0631, 0.7147, -0.2050, -0.1241, 1.4897, 1.4090, 1.4172};
    float y2[] = {0.6715, -1.2075, 0.7172, 1.6302, 0.4889, 1.0347, 0.7269, -0.3034, 0.2939, -0.7873, 0.8884, -1.1471, -1.0689, -0.8095, -2.9443};
    int len_x2 = sizeof(x2) / sizeof(x2[0]);
    int len_y2 = sizeof(y2) / sizeof(y2[0]);
    int len_Rxy = len_x2 + len_y2 - 1;
    float *Rxy = correlation(x2, len_x2, y2, len_y2);
    printf("Correlation : ");
    print_array(Rxy, len_Rxy);

    float x3[] = {0.3252, -0.7549, 1.3703, -1.7115, -0.1022, -0.2414, 0.3192, 0.3129, -0.8649, -0.0301, -0.1649, 0.6277, 1.0933, 1.1093, -0.8637, 0.0774, -1.2141, -1.1135, -0.0068, 1.5326, -0.7697, 0.3714, -0.2256, 1.1174, -1.0891, 0.0326, 0.5525, 1.1006, 1.5442, 0.0859, -1.4916, -0.7423, -1.0616, 2.3505, -0.6156, 0.7481};
    int len_x3 = sizeof(x3) / sizeof(x3[0]);
    int M = 2;
    int len_y3 = 1 + (len_x3 - 1) / M;
    float *y3 = downsampler(x3, len_x3, M);
    printf("Downsampling for M = 2 : ");
    print_array(y3, len_y3);

    M = 3;
    len_y3 = 1 + (len_x3 - 1) / M;
    y3 = downsampler(x3, len_x3, M);
    printf("Downsampling for M = 3 : ");
    print_array(y3, len_y3);

    float x4[] = {0.3252, 1.3703, -0.1022, 0.3192, -0.8649, -0.1649, 1.0933, -0.8637, -1.2141, -0.0068, -0.7697, -0.2256, -1.0891, 0.5525, 1.5442, -1.4916, -1.0616, -0.6156};
    int len_x4 = sizeof(x4) / sizeof(x4[0]);
    int L = 2;
    int len_y4 = L * len_x4;
    float *y4 = upsampler(x4, len_x4, L);
    printf("Upsampling for L = 2 : ");
    print_array(y4, len_y4);

    L = 3;
    len_y4 = L * len_x4;
    y4 = upsampler(x4, len_x4, L);
    printf("Upsampling for L = 3 : ");
    print_array(y4, len_y4);

    return 0;
}
