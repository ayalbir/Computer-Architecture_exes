/* 214104226 Ayal Birenstock */
.extern printf
.extern scanf
.extern pstrlen
.extern swapCase
.extern pstrijcpy

.section .rodata
ch_31: .string "first pstring length: %d, second pstring length: %d\n"
ch_33: .string "length: %d, string: %s\n"
ch_34: .string "%d %d"
gg: .string "invalid option!\n"
np: .string "invalid input!\n"

.section .text
.global run_func
.type run_func, @function
run_func:
    # calle, backup
    pushq %rbp
    movq %rsp, %rbp

    # the first arg is the choice

    # switch case
    cmp $31, %rdi
    je .case_31
    cmp $33, %rdi
    je .case_33
    cmp $34, %rdi
    je .case_34
    jmp .invalid

.case_31:
    #the args are rdi, rsi, rdx, rcx, r8, r9
    #we have      ch,  p1, p2
    movq %rsi, %rdi
    call pstrlen
    movq %rax, %rsi
    movq %rdx, %rdi
    call pstrlen
    movq %rax, %rdx
    movq $ch_31, %rdi
    xorq %rax, %rax
    call printf
    jmp .end


.case_33:
    #still need the length of both strings
    movq %rsi, %rdi
    movq %rsi, %r13 #save the pointer
    call pstrlen
    movq %rax, %r14 #save for later


    movq %rdx, %r15 #save the pointer
    movq %r13, %rdi
    call swapCase

    movq $ch_33, %rdi
    movq %r14, %rsi
    incq %r13 # move forward to the string itself
    movq %r13, %rdx
    xorq %rax, %rax
    call printf

    movq %r15, %rdi
    call pstrlen
    movq %rax, %r14 #no need the first length anymore
    movq %r15, %rdi #not calle so again
    call swapCase
    movq $ch_33, %rdi
    movq %r14, %rsi
    incq %r15 # move forward to the string itself
    movq %r15, %rdx
    xorq %rax, %rax
    call printf
    jmp .end


.case_34:
    # save the strings 
    movq %rsi, %r15
    movq %rdx, %r12

    # get the length of the strings
    movq %rsi, %rdi
    call pstrlen
    movq %rax, %r13
    movq %rdx, %rdi
    call pstrlen
    movq %rax, %r14

    # save the strings in the stack
    sub $16, %rsp
    movq $ch_34, %rdi
    leaq -16(%rbp), %rsi
    leaq -12(%rbp), %rdx
    xorq %rax, %rax
    call scanf

    # check if valid
    movq %r15, %rdi
    movq %r12, %rsi
    movzbq -16(%rbp), %rdx
    movzbq -12(%rbp), %rcx

    # check if j\ge i
    cmpq %rdx, %rcx
    jl invalid_opt34
    # check if i\ge 0 and j\ge 0
    cmpq %rcx, %r13
    jl invalid_opt34
    cmpq %rcx, %r14
    jl invalid_opt34
    call pstrijcpy

    # print the strings
    movq $ch_33, %rdi
    movq %r13, %rsi
    incq %r15 # move forward to the string itself
    movq %r15, %rdx
    xorq %rax, %rax
    call printf

    movq $ch_33, %rdi
    movq %r14, %rsi
    incq %r12 # move forward to the string itself
    movq %r12, %rdx
    xorq %rax, %rax
    call printf
    jmp .end

invalid_opt34:
    # print invalid
    movq $gg, %rdi
    xorq %rax, %rax
    call printf

    # print the strings
    movq $ch_33, %rdi
    movq %r13, %rsi
    incq %r15 # move forward to the string itself
    movq %r15, %rdx
    movq %r15, %rdx
    xorq %rax, %rax
    call printf

    # print the strings
    movq $ch_33, %rdi
    movq %r14, %rsi
    incq %r12 # move forward to the string itself
    movq %r12, %rdx
    movq %r12, %rdx
    xorq %rax, %rax
    call printf
    jmp .end


.invalid:
    # print invalid
    xorq %rax, %rax
    movq  $np, %rdi
    call printf
    jmp .end

.end:
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
