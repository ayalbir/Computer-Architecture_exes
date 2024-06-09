/* 214104226 Ayal Birenstock */
.extern rand
.extern printf
.extern scanf

.section .data
user_seed: .long
user_guess: .long

.section .rodata
fm: .string "Enter configuration seed: "
scanf_fmt: .string "%d"
que:  .string "What is your guess? "
wn: .string "Congratz! You Won!\n"
wr:  .string "Incorrect.\n"
lst:  .string "Game over, you lost :(. The correct answer was %d\n"

.section .text
.globl main
.type   main, @function
main:
    # in
    pushq   %rbp
    movq    %rsp, %rbp

    # Print message
    movq    $fm, %rdi
    xorq    %rax, %rax
    call    printf

    # Get the seed
    movq    $scanf_fmt, %rdi
    movq    $user_seed, %rsi
    xorq    %rax, %rax
    call    scanf

    # seed the random number generator
    movq    user_seed, %rdi
    xorq    %rax, %rax
    call    srand

    # Generate a random number, 0-9
    xorq    %rax, %rax
    call    rand
    movq    %rax, %r15 

    #limit the number to 0-9, and store in r15
    movq    %r15, %rax
    xorq    %rdx, %rdx
    mov     $10, %rcx
    idiv    %rcx
    movq    %rdx, %r15
    
    # init counter
    movq    $0, %r14
    movq    $5, %r13

.loop:
    cmp    %r14, %r13
    je     .end
    movq   $que, %rdi
    xorq   %rax, %rax
    call   printf

    # get guess from the user
    movq $scanf_fmt, %rdi
    movq $user_guess, %rsi
    xorq %rax, %rax
    call scanf

    # compare the guess to the random number
    cmp user_guess, %r15
    je .win

    # wrong guess
    xorq %rax, %rax
    movq $wr, %rdi
    call printf
    

    inc %r14
    jmp .loop

.end:
    xorq %rax, %rax
    movq $lst, %rdi
    movq %r15, %rsi
    call printf
    jmp .exit

.win:
    xorq %rax, %rax
    movq $wn, %rdi
    call printf
    jmp exit

.exit:
    # out
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
