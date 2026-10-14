# PC_Lab9

## SE3082 — Lab 09: CUDA GPU Programming

**Student ID:** IT24104155  
**Year:** 2026

This lab explores parallel programming with CUDA, from launching a simple GPU kernel to processing large vectors and matrices. The activities cover device memory allocation, data transfers between the CPU and GPU, thread and block indexing, and checking GPU results against CPU calculations.

### Exercise overview

| Folder | Activity | CUDA configuration |
| --- | --- | --- |
| [Exercise01](Exercise01) | Print a message from each GPU thread | 1 block × 4 threads |
| [Exercise02](Exercise02) | Add two integers on the GPU | 1 block × 1 thread |
| [Exercise03](Exercise03) | Add two vectors of 512 elements | 512 blocks × 1 thread |
| [Exercise04](Exercise04) | Add two vectors of 512 elements | 1 block × 512 threads |
| [Exercise05](Exercise05) | Multiply two vectors of 10,000,000 elements | 512 threads per block with a bounds check |
| [Exercise06](Exercise06) | Multiply two 10,000 × 10,000 matrices element by element | 2D grid with 32 × 16 threads per block |

Exercise 6 computes an **element-wise product**, rather than a matrix multiplication.

### Work progress

- All six CUDA programs are included in separate exercise folders.
- The notebook retains the exercise headings and instructions, with a Colab link for this repository.
- A Makefile is included to build and run the standalone programs.
- Vector and matrix exercises include CPU comparisons that report mismatch counts.
- Saved notebook outputs have been cleared. Fresh GPU execution and verification are still pending; no new successful run is claimed here.

### Run in Google Colab

[Open IT24104155_Lab9.ipynb in Colab](https://colab.research.google.com/github/IT24104155/se3082-lab-09-2026/blob/main/notebooks/IT24104155_Lab9.ipynb)

1. Select a GPU runtime.
2. Run the environment checks at the beginning of the notebook.
3. Run the exercise cells in order. The notebook uses `-arch=sm_75`; adjust this flag if your GPU requires a different architecture.
4. Review the results and confirm that vector and matrix verification reports zero mismatches.

### Build locally

Requires the NVIDIA CUDA Toolkit, a compatible GPU, and GNU make.

```sh
make
make run
make clean
```

Exercise 2 should print `Result is 9`. Exercises 3–6 should report zero mismatches when they run successfully. Exercise 6 uses approximately 1.2 GB of host memory and 1.2 GB of GPU memory for its three arrays.

### Repository notes

The original README title is retained above. The supplied exercise text is preserved in the [notebook](notebooks/IT24104155_Lab9.ipynb). See [GUIDE.md](GUIDE.md) for additional build notes and [SOURCES.md](SOURCES.md) for source attribution.
