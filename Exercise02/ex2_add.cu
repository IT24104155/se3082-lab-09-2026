#include <cstdio>

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

int main(void) {
    int a, b, c;
    int *d_a, *d_b, *d_c;
    int size = sizeof(int);

    // Allocate memory on the GPU
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // Input values
    a = 2;
    b = 7;

    // Copy inputs from CPU to GPU
    cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

    // Launch one block containing one thread
    add<<<1, 1>>>(d_a, d_b, d_c);

    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess)
        printf("Kernel launch failed: %s\n",
               cudaGetErrorString(err));

    // Copy result from GPU to CPU
    cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);
    printf("Result is %d\n", c);

    // Release GPU memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
