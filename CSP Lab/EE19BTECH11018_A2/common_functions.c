#include <stdio.h>
#include <malloc.h>
#include <math.h>
#include "common_functions.h"

#define pi 3.14159

float *LPF(float fc, float fs, int N)
{
    float wc = (2 * pi * fc) / fs;
    float *hd;
    hd = (float *)malloc(N * sizeof(float));

    for (int n = -(N - 1) / 2; n < (N + 1) / 2; n++)
    {
        if (n == 0)
        {
            hd[n + (N - 1) / 2] = wc / pi;
        }
        else
        {
            hd[n + (N - 1) / 2] = sin(wc * n) / (pi * n);
        }
    }

    return hd;
}

float *BPF(float fc1, float fc2, float fs, int N)
{
    float wc1 = (2 * pi * fc1) / fs;
    float wc2 = (2 * pi * fc2) / fs;
    float *hd;
    hd = (float *)malloc(N * sizeof(float));

    for (int n = -(N - 1) / 2; n < (N + 1) / 2; n++)
    {
        if (n == 0)
        {
            hd[n + (N - 1) / 2] = (wc2 - wc1) / pi;
        }
        else
        {
            hd[n + (N - 1) / 2] = sin(wc2 * n) / (pi * n) - sin(wc1 * n) / (pi * n);
        }
    }

    return hd;
}

float *hamming_window(int N)
{
    float *w;
    w = (float *)malloc(N * sizeof(float));

    for (int n = 0; n < N; n++)
    {
        w[n] = 0.54 - 0.46 * cos(2 * pi * n / (N - 1));
    }

    return w;
}

float *multiply(float *arr1, float *arr2, int len)
{
    float *arr3 = (float *)malloc(len * sizeof(float));
    for (int i = 0; i < len; i++)
    {
        arr3[i] = arr1[i] * arr2[i];
    }

    return arr3;
}

void print_array(float *arr, int len)
{
    printf("{ ");
    int i = 0;
    for (; i < len - 1; i++)
    {
        printf("%f, ", arr[i]);
    }
    printf("%f }", arr[i]);
    printf("\n\n");
}