# Computer Architecture Assignment 1

### Overview
This assignment consists of two parts:
1. Implementing a Number Guessing Game in Assembly
2. Creating a String Library in Assembly

Each part requires writing different files and implementing various functionalities using assembly language.

### Part I: Number Guessing Game

In this part, a simple number guessing game is implemented in assembly. The game involves:
- Prompting the user to enter a seed value for the `rand()` function.
- Generating a random number between 0 and 10.
- Allowing the user to guess the number with a maximum of 5 attempts.
- Providing feedback on whether the guess is correct or incorrect.
- Ending the game when the number is guessed correctly or the maximum attempts are reached.
- Displaying appropriate messages for winning or losing the game.

**Implementation Details:**
- The code is written in a file named `main.s`.
- The program compiles using the command `gcc main.s -no-pie`.

**Example Usage:**

1. **Compiling the Game:**
    ```bash
    gcc main.s -no-pie -o game
    ```

2. **Running the Game:**
    ```bash
    ./game
    ```

3. **Sample Interaction:**
    ```bash
    Enter a seed value: 123
    What is your guess? 5
    Incorrect.
    What is your guess? 3
    Incorrect.
    What is your guess? 7
    Congratz! You won!
    ```

### Part II: String Library

In this part, a simple string library is implemented in assembly. The tasks include:
- Implementing various string manipulation functions.
- Writing a menu-driven program to select and execute these functions based on user input.

**Files Provided:**
- `pstrings.h`: Header file with structure and function declarations.
- `main.c`: Implementation of the main function.
- `Makefile`: Project builder.
- `pstring.s` and `func_select.s`: Files to be implemented.

**Function Details:**
- `pstrlen(Pstring* pstr)`: Returns the length of the given Pstring.
- `swapCase(Pstring* pstr)`: Swaps the case of each character in the given Pstring.
- `pstrijcpy(Pstring* dst, Pstring* src, char i, char j)`: Copies a substring from `src` to `dst` based on the given indices.

**Function Behaviors in `func_select.s`:**
- Choice `31`: Calls `pstrlen` and prints the lengths of the strings.
- Choice `33`: Calls `swapCase` and prints the modified strings.
- Choice `34`: Calls `pstrijcpy` and prints the resulting strings.
- Any other choice: Prints "invalid option!".

**Implementation Details:**
- The code is written in files named `pstring.s` and `func_select.s`.
- Only `scanf` and `printf` from libc are allowed.
- No dynamic memory allocation; stack usage is required.
- Proper calling conventions and prolog/epilog must be followed.

**Example Usage:**

1. **Compiling the String Library:**
    ```bash
    make
    ```

2. **Running the Program:**
    ```bash
    ./main
    ```

3. **Sample Interaction:**
    ```bash
    Enter the first string (length < 254): hello
    Enter the second string (length < 254): world

    Menu:
    31 - Get lengths of the strings
    33 - Swap case of the strings
    34 - Copy substring
    Enter your choice: 31
    First pstring length: 5, second pstring length: 5

    Menu:
    31 - Get lengths of the strings
    33 - Swap case of the strings
    34 - Copy substring
    Enter your choice: 33
    Length: 5, string: HELLO
    Length: 5, string: WORLD

    Menu:
    31 - Get lengths of the strings
    33 - Swap case of the strings
    34 - Copy substring
    Enter your choice: 34
    Enter start index: 1
    Enter end index: 3
    Length: 5, string: hELLO
    Length: 5, string: wORLD
    ```

### Conclusion
This README provides an overview of the tasks completed in the assignment, showcasing the implementation details and guidelines followed. Detailed instructions and example usages are provided to demonstrate how to compile and run the code for each part.
