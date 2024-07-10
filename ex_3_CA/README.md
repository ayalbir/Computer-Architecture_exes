# Computer Architecture Assignment 3

### Overview
This assignment consists of three parts:
1. Simulating a Cache
2. Optimizing a Vertex Cover Algorithm
3. Patching a Binary to Reveal a Secret Flag

Each part requires specific tasks to be completed, adhering to the guidelines provided.

### Part 1: Simulating the Cache
This section involves creating a cache simulator with the following components:
- **Struct Definitions:**
  - `cache_line_t`: Represents a single cache line.
  - `cache_t`: Represents the cache structure.
- **Functions:**
  - `initialize_cache(uchar s, uchar t, uchar b, uchar E)`: Initializes the cache.
  - `read_byte(cache_t cache, uchar* start, long int off)`: Reads a byte from the cache.
  - `write_byte(cache_t cache, uchar* start, long int off, uchar new)`: Writes a byte to the cache.
- The cache replacement policy is LFU (Least Frequently Used).

**Main Function:**
The main function demonstrates the usage of the cache by simulating reads and displaying the cache state.

### Part 2: Optimization
This section involves optimizing a given implementation of the minimal Vertex Cover problem. The optimization should:
- Retain the same functionality and output as the original code.
- Improve the performance of the `isVertexCover`, `generateCombinations`, and `findMinVertexCover` functions in `vertex-cover.c`.
- Testing involves using a provided Python script to generate test cases and comparing performance before and after optimization.

### Part 3: Patching
This section involves reverse engineering a binary to print a secret flag. The steps taken to achieve this are documented in a file named `cheating_is_bad`.


### Example Usage
To compile and run the cache simulator:
```bash
cd cache
make
./cache
```

To compile and run the optimized vertex cover algorithm:
```bash
cd optimizations
make
./cover
```

### Conclusion
This README provides an overview of the tasks completed in the assignment, showcasing the implementation details and guidelines followed.
