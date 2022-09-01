float *multiply(float *arr1, float *arr2, int len);
float *LPF(float fc, float fs, int N);
float *BPF(float fc1, float fc2, float fs, int N);
float *hamming_window(int N);
void print_array(float *arr, int len);