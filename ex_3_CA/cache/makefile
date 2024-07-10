# 214104226 Ayal Birenstock
CC = gcc
CFLAGS = -g
MAIN = cache

.PHONY: all clean

all: $(MAIN)

$(MAIN): main.o
	$(CC) $(CFLAGS) $^ -o $@ -no-pie

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

clean:
	rm -f *.o $(MAIN)