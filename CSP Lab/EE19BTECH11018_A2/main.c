#include <stdio.h>
#include <malloc.h>
#include "common_functions.h"

int main()
{
    float fc = 400;
    float fs = 1600;
    int N = 39;
    float *w = hamming_window(N);

    float *hd = LPF(fc, fs, N);
    float *Practical_LPF1 = multiply(hd, w, N);
    printf("Practical_LPF1 = ");
    print_array(Practical_LPF1, N);

    fs = 3200;
    hd = LPF(fc, fs, N);
    float *Practical_LPF2 = multiply(hd, w, N);
    printf("Practical_LPF2 = ");
    print_array(Practical_LPF2, N);

    float fc1 = 500;
    float fc2 = 1200;
    fs = 6000;
    hd = BPF(fc1, fc2, fs, N);
    float *Practical_BPF = multiply(hd, w, N);
    printf("Practical_BPF = ");
    print_array(Practical_BPF, N);

    return 0;
}