#include <stdio.h>
#include <malloc.h>
#include "common_functions.h"

float *convolution(float *x, int len_x, float *h, int len_h)
{
    float *y;
    int len_y = len_x + len_h - 1;
    y = (float *)malloc(len_y * sizeof(float));

    for (int n = 0; n < len_y; n++)
    {
        y[n] = 0;
        for (int k = 0; k < len_x; k++)
        {
            if (n - k >= 0 && n - k < len_h)
            {
                y[n] = y[n] + x[k] * h[n - k];
            }
        }
    }
    return y;
}

float *correlation(float *x, int len_x, float *y, int len_y)
{
    float *Rxy;
    int len_Rxy = len_x + len_y - 1;
    Rxy = (float *)malloc(len_Rxy * sizeof(float));

    for (int k = -(len_y - 1); k < len_Rxy - (len_y - 1); k++)
    {
        Rxy[k + (len_y - 1)] = 0;
        for (int n = 0; n < len_x; n++)
        {
            if (n - k >= 0 && n - k < len_y)
            {
                Rxy[k + (len_y - 1)] = Rxy[k + (len_y - 1)] + x[n] * y[n - k];
            }
        }
    }
    return Rxy;
}

float *downsampler(float *x, int len_x, int M)
{
    float *y;
    int len_y = 1 + (len_x - 1) / M;
    y = (float *)malloc(len_y * sizeof(float));

    for (int n = 0; n < len_y; n++)
    {
        y[n] = x[M * n];
    }
    return y;
}

float *upsampler(float *x, int len_x, int L)
{
    float *y;
    int len_y = L * len_x;
    y = (float *)malloc(len_y * sizeof(float));

    for (int n = 0; n < len_y; n++)
    {
        if (n % L == 0)
        {
            y[n] = x[n / L];
        }
        else
        {
            y[n] = 0;
        }
    }
    return y;
}

void print_array(float *arr, int len)
{
    printf("{ ");
    for (int i = 0; i < len; i++)
    {
        printf("%f, ", arr[i]);
    }
    printf("\b\b }\n\n");
}