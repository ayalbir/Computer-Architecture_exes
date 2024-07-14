# 214104226 Ayal Birenstock
CC = gcc
CFLAGS = -O0
TARGET = cover

all: $(TARGET)

$(TARGET): main.o vertex-cover.o
	$(CC) $(CFLAGS) -o $(TARGET) main.o vertex-cover.o

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

vertex-cover.o: vertex-cover.c
	$(CC) $(CFLAGS) -c vertex-cover.c

clean:
	rm -f *.o $(TARGET)
