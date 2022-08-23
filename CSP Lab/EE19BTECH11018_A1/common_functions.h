float *convolution(float *x, int len_x, float *h, int len_h);
float *correlation(float *x, int len_x, float *y, int len_y);
float *downsampler(float *x, int len_x, int M);
float *upsampler(float *x, int len_x, int L);
void print_array(float *arr, int n);