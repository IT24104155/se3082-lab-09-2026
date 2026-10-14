# Lab 09 — IT24104155

README.md retains the original `PC_Lab9` title and adds an exercise overview and progress notes. The supplied exercise headings and instructions are preserved in the notebook.

Open [the notebook in Colab](https://colab.research.google.com/github/IT24104155/se3082-lab-09-2026/blob/main/notebooks/IT24104155_Lab9.ipynb), select a GPU runtime, and run cells in order. Its previous outputs were cleared so new runs generate your own evidence. The notebook's original compile commands target `sm_75`; adjust these if the selected GPU requires another architecture.

| Folder | Activity |
| --- | --- |
| Exercise01 | Hello from four GPU threads |
| Exercise02 | Scalar addition |
| Exercise03 | Vector addition: 512 blocks, one thread each |
| Exercise04 | Vector addition: one block, 512 threads |
| Exercise05 | Multiply 10,000,000 vector elements |
| Exercise06 | Element-wise multiplication of two 10,000 × 10,000 matrices |

Standalone sources are extracted from the notebook without code changes.

On a CUDA system with GNU make:

```sh
make
make run
# Optional architecture override:
make clean
make CUDAFLAGS='-O2 -arch=sm_75'
```

Exercise 6 requires approximately 1.2 GB each of host and device storage for its three integer arrays. The vector and matrix programs print mismatch counts for CPU comparison. CUDA compilation and GPU execution have not been verified here because the CUDA tools are unavailable.

See SOURCES.md for source credit.
