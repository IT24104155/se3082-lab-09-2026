NVCC ?= nvcc
CUDAFLAGS ?= -O2
PROGRAMS = bin/hello bin/ex2_add bin/ex3_blocks bin/ex4_threads bin/ex5_vecmul bin/ex6_matrix

.PHONY: all run clean
all: $(PROGRAMS)
bin:
	mkdir -p bin
bin/hello: Exercise01/hello.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
bin/ex2_add: Exercise02/ex2_add.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
bin/ex3_blocks: Exercise03/ex3_blocks.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
bin/ex4_threads: Exercise04/ex4_threads.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
bin/ex5_vecmul: Exercise05/ex5_vecmul.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
bin/ex6_matrix: Exercise06/ex6_matrix.cu | bin
	$(NVCC) $(CUDAFLAGS) $< -o $@
run: all
	set -e; for program in $(PROGRAMS); do ./$$program; done
clean:
	rm -rf bin
