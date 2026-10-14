#include <cstdio>
#include <cstdlib>

#define ROWS 10000
#define COLS 10000

// Element-wise product: C[r][c] = A[r][c] * B[r][c]
__global__ void mulElem(int *a, int *b, int *c,
                        int rows, int cols) {
    // TODO 1: Calculate the row and column of this thread
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    // TODO 2: Check that both coordinates are within bounds
    if (row < rows && col < cols) {
        // TODO 3: Convert the 2D coordinates to a flat index
        int idx = row * cols + col;
        c[idx] = a[idx] * b[idx];
    }
}

void random_ints(int *x, size_t size) {
    for (size_t i = 0; i < size; i++)
        x[i] = rand() % 100;
}

int main(void) {
    int *a, *b, *c;             // Host copies, stored as flat arrays
    int *d_a, *d_b, *d_c;       // Device copies

    size_t count = (size_t)ROWS * COLS;
    size_t size = count * sizeof(int);

    // Allocate device memory
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // Allocate host memory and generate input values
    a = (int *)malloc(size);
    random_ints(a, count);

    b = (int *)malloc(size);
    random_ints(b, count);

    c = (int *)malloc(size);

    // Copy inputs to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    // 32 x 16 = 512 threads per block
    dim3 threadsPerBlock(32, 16);

    // TODO 4: Calculate the grid dimensions, rounding up
    dim3 numBlocks(
        (COLS + threadsPerBlock.x - 1) / threadsPerBlock.x,
        (ROWS + threadsPerBlock.y - 1) / threadsPerBlock.y
    );

    printf("Grid: %d x %d blocks\n",
           numBlocks.x, numBlocks.y);

    // TODO 5: Launch the kernel
    mulElem<<<numBlocks, threadsPerBlock>>>(
        d_a, d_b, d_c, ROWS, COLS
    );

    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess)
        printf("Kernel launch failed: %s\n",
               cudaGetErrorString(err));

    // TODO 6: Copy the result back to the host
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

    // TODO 7: Print C[9999][9000] through C[9999][9999]
    printf("\nLast 1000 matrix elements:\n");

    for (int col = 9000; col < COLS; col++) {
        int idx = (ROWS - 1) * COLS + col;

        printf("C[%d][%d] = %d x %d = %d\n",
               ROWS - 1, col, a[idx], b[idx], c[idx]);
    }

    // TODO 8: Verify all elements using the CPU
    int errors = 0;

    for (size_t i = 0; i < count; i++) {
        if (c[i] != a[i] * b[i])
            errors++;
    }

    printf("\nVerification: %d mismatches out of %zu\n",
           errors, count);

    // Cleanup
    free(a);
    free(b);
    free(c);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}
