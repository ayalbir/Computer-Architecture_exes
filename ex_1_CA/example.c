// this is how I would write the code in C, and later I will convert it to assembly

#include <stdio.h>
#include <stdlib.h>


int N = 10;
int M = 5;

int main() {

    // get a number from the user to use it as the seed
    int x;
    printf("Enter configuration seed: ");
    scanf("%d", &x);
    // use the seed to generate a random number between 0 and N
    srand(x);
    // Generate a random number between 0 and n (exclusive)
    int random_number = rand() % (N);
    int winCheck = 0;
    // now that we have the number, we can really start the game.
    for (int i = 0; i < M; i++)
    {
        printf("What is your guess? ");
        int g;
        scanf("%d", &g);
        if (g == random_number)
        {
            winCheck = 1;
            break;
        }
        printf("Incorrect.\n");
    }
    if (winCheck)
    {
        printf("Congratz! You won!");
    }
    else {
        printf("Game over, you lost :'('. The correct number was %d", random_number);
    }
    return 0;
    
}