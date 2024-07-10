// 214104226 Ayal Birenstock

#include <stdio.h>
#include <stdlib.h>


typedef unsigned char uchar;

typedef struct cache_line_s
{
    uchar valid;
    uchar frequency;
    long int tag;
    uchar *block;
} cache_line_t;

typedef struct cache_s
{
    uchar s;
    uchar t;
    uchar b;
    uchar E;
    cache_line_t **cache;
} cache_t;

cache_t initialize_cache(uchar s, uchar t, uchar b, uchar E);
uchar read_byte(cache_t cache, uchar *start, long int off);
void write_byte(cache_t cache, uchar *start, long int off, uchar new);

void print_cache(cache_t cache)
{
    int S = 1 << cache.s;
    int B = 1 << cache.b;

    for (int i = 0; i < S; i++)
    {
        printf("Set %d\n", i);
        for (int j = 0; j < cache.E; j++)
        {
            printf("%1d %d 0x%0*lx ", cache.cache[i][j].valid,
                   cache.cache[i][j].frequency, cache.t, cache.cache[i][j].tag);
            for (int k = 0; k < B; k++)
            {
                printf("%02x ", cache.cache[i][j].block[k]);
            }
            puts("");
        }
    }
}

cache_t initialize_cache(uchar s, uchar t, uchar b, uchar E)
{
    cache_t newCache;
    newCache.s = s;
    newCache.t = t;
    newCache.b = b;
    newCache.E = E;

    // Allocate memory for cache, based on s
    int S = 1 << s;
    newCache.cache = malloc(S * sizeof(cache_line_t *));

    // Allocate memory for each set
    for (int i = 0; i < S; i++)
    {
        newCache.cache[i] = malloc(E * sizeof(cache_line_t));
        for (int j = 0; j < E; j++)
        {
            newCache.cache[i][j].valid = 0;
            newCache.cache[i][j].frequency = 0;
            newCache.cache[i][j].tag = 0;
            newCache.cache[i][j].block = malloc((1 << b) * sizeof(uchar));
        }
    }
    return newCache;
}

uchar read_byte(cache_t cache, uchar *start, long int off)
{
    // get the set, tag and block
    int S = 1 << cache.s;
    int B = 1 << cache.b;
    long int tag = off >> (cache.s + cache.b);
    int set = (off >> cache.b) & (S - 1);
    int block = off & (B - 1);

    // see if already in cache
    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].valid && cache.cache[set][i].tag == tag)
        {
            cache.cache[set][i].frequency++;
            return cache.cache[set][i].block[block];
        }
    }

    // if not in cache, find the least recently used
    int min = 0;
    for (int i = 1; i < cache.E; i++)
    {
        if (cache.cache[set][i].frequency < cache.cache[set][min].frequency)
        {
            min = i;
        }
    }

    // if not valid, just read from memory
    if (!cache.cache[set][min].valid)
    {
        cache.cache[set][min].valid = 1;
        cache.cache[set][min].tag = tag;
        cache.cache[set][min].frequency = 1;
        for (int i = 0; i < B; i++)
        {
            cache.cache[set][min].block[i] = start[(off & ~(B - 1)) + i];
        }
        return cache.cache[set][min].block[block];
    }

    // if valid, write back to memory
    for (int i = 0; i < B; i++)
    {
        start[(off & ~(B - 1)) + i] = cache.cache[set][min].block[i];
    }
    cache.cache[set][min].tag = tag;
    cache.cache[set][min].frequency = 1;
    for (int i = 0; i < B; i++)
    {
        cache.cache[set][min].block[i] = start[(off & ~(B - 1)) + i];
    }
    return cache.cache[set][min].block[block];
}

void write_byte(cache_t cache, uchar *start, long int off, uchar new)
{
    // get the set, tag and block
    int S = 1 << cache.s;
    int B = 1 << cache.b;
    long int tag = off >> (cache.s + cache.b);
    int set = (off >> cache.b) & (S - 1);
    int block = off & (B - 1);

    // see if already in cache
    for (int i = 0; i < cache.E; i++)
    {
        if (cache.cache[set][i].valid && cache.cache[set][i].tag == tag)
        {
            cache.cache[set][i].block[block] = new;
            cache.cache[set][i].frequency++;
            start[off] = new;
            return;
        }
    }

    // if not in cache, find the least recently used
    int min = 0;
    for (int i = 1; i < cache.E; i++)
    {
        if (cache.cache[set][i].frequency < cache.cache[set][min].frequency)
        {
            min = i;
        }
    }

    // if not valid, load from memory and update
    if (!cache.cache[set][min].valid)
    {
        cache.cache[set][min].valid = 1;
        cache.cache[set][min].tag = tag;
        cache.cache[set][min].frequency = 1;
        for (int i = 0; i < B; i++)
        {
            cache.cache[set][min].block[i] = start[(off & ~(B - 1)) + i];
        }
        cache.cache[set][min].block[block] = new;
        start[off] = new;
        return;
    }

    // if valid, write back to memory
    for (int i = 0; i < B; i++)
    {
        start[(off & ~(B - 1)) + i] = cache.cache[set][min].block[i];
    }
    cache.cache[set][min].tag = tag;
    cache.cache[set][min].frequency = 1;
    for (int i = 0; i < B; i++)
    {
        cache.cache[set][min].block[i] = start[(off & ~(B - 1)) + i];
    }
    cache.cache[set][min].block[block] = new;
    start[off] = new;
}

int main()
{
    int n;
    printf("Size of data: ");
    scanf("%d", &n);
    uchar *mem = malloc(n);
    printf("Input data >> ");
    for (int i = 0; i < n; i++)
        scanf("%hhd", mem + i);

    int s, t, b, E;
    printf("s t b E: ");
    scanf("%d %d %d %d", &s, &t, &b, &E);
    cache_t cache = initialize_cache(s, t, b, E);
    while (1)
    {
        scanf("%d", &n);
        if (n < 0)
            break;
        read_byte(cache, mem, n);
    }
    puts("");
    print_cache(cache);
    free(mem);
}
