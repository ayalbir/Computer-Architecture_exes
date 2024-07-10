from random import randint

n = int(input("n - "))

for j in range(n):
    barr = [str(randint(0,1)) for i in range(n)]
    print(' '.join(barr))

