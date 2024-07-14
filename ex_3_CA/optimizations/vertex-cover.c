#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_VERTICES 100

#define INDEX(x, y, n) ((x) * (n) + (y))

bool isVertexCover(int graph[MAX_VERTICES][MAX_VERTICES], int n, int cover[], int k) {
    bool edges_covered[MAX_VERTICES * MAX_VERTICES] = {false};

    // Check for covered edges
    int i = 0;
    while (i <= k - 2) {
        int v0 = cover[i];
        int v1 = cover[i + 1];

        int *graph_v0 = graph[v0];
        int *graph_v1 = graph[v1];

        for (int j = 0; j < n; j++) {
            if (graph_v0[j]) {
                edges_covered[INDEX(v0, j, n)] = true;
                edges_covered[INDEX(j, v0, n)] = true;
            }
            if (graph_v1[j]) {
                edges_covered[INDEX(v1, j, n)] = true;
                edges_covered[INDEX(j, v1, n)] = true;
            }
        }
        i += 2;
    }

    while (i < k) {
        int v = cover[i];
        int *graph_v = graph[v];
        for (int j = 0; j < n; j++) {
            if (graph_v[j]) {
                edges_covered[INDEX(v, j, n)] = true;
                edges_covered[INDEX(j, v, n)] = true;
            }
        }
        i++;
    }

    // Check if all edges are covered
    i = 0;
    while (i < n) {
        int j = i + 1;
        while (j <= n - 2) {
            bool not_covered_ij = !edges_covered[INDEX(i, j, n)] || !edges_covered[INDEX(j, i, n)];
            bool not_covered_ij1 = !edges_covered[INDEX(i, j + 1, n)] || !edges_covered[INDEX(j + 1, i, n)];
            if ((graph[i][j] && not_covered_ij) || (graph[i][j + 1] && not_covered_ij1)) {
                return false;
            }

            j += 2;
        }

        // if n is odd
        if (j < n && graph[i][j] && (!edges_covered[INDEX(i, j, n)] || !edges_covered[INDEX(j, i, n)])) {
            return false;
        }

        i++;
    }

    return true;
}


void generateCombinations(int n, int k, int cover[], int start, int currentSize,
                          int graph[MAX_VERTICES][MAX_VERTICES], int *minCover, int *minSize)
{
    if (currentSize == k)
    {
        if (isVertexCover(graph, n, cover, k))
        {
            if (k < *minSize)
            {
                *minSize = k;
                for (int i = 0; i < k; i++)
                {
                    minCover[i] = cover[i];
                }
            }
        }
        return;
    }
    int max = n - (k - currentSize);
    for (int i = start; i <= max; i++)
    {
        cover[currentSize] = i;
        generateCombinations(n, k, cover, i + 1, currentSize + 1, graph, minCover, minSize);
        if (*minSize <= k)
            return; // Early termination if we've found a solution of size k or smaller
    }
}

void findMinVertexCover(int graph[MAX_VERTICES][MAX_VERTICES], int n)
{
    int *minCover = (int *)malloc(n * sizeof(int));
    int *cover = (int *)malloc(n * sizeof(int));
    int minSize = n + 1;

    for (int k = 1; k <= n && minSize > k; k++)
    {
        generateCombinations(n, k, cover, 0, 0, graph, minCover, &minSize);
    }

    printf("Minimum Vertex Cover: ");
    for (int i = 0; i < minSize; i++)
    {
        printf("%d ", minCover[i]);
    }
    printf("\nSize: %d\n", minSize);

    free(minCover);
    free(cover);
}