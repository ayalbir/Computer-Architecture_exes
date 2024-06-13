// this is the function that selects the function to do based on the input in the main. the function themselves are implemented in the pstrings.s file
// so guess will need to import the functions from the pstrings.s file
// well it doesn't seem to be variadic functions so I can just call them directly

// need to do switch case on 31, 33 and 34. every other option is invalid.

// there is run_func (and also main?)

/* 214104226 Ayal Birenstock */

.extern printf
.extern scanf
.extern pstrlen
.extern swapCase
.extern pstrijcpy

.section .rodata
ch_31: .string "first pstring length: %d, second pstring length : %d\n"
ch_33: .string "length: %d, string: %s\n"
ch_34: .string "%d %d"
gg: .string "invaild option!\n"

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
    movq %rsi, %r13
    call pstrlen
    movq %rax, %r14 #save for later


    movq %rdx, %r15
    movq %r13, %rdi
    call swapCase
    movq $ch_33, %rdi
    
    movq %r14, %rsi
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
    movq %r15, %rdx
    xorq %rax, %rax
    call printf
    jmp .end


.case_34:
    #since there is no data section, we will need to use the stack
    #the args are rdi, rsi, rdx, rcx, r8, r9
    #we have      ch,  p1, p2
    #save the pstrings
    movq %rsi, %r10
    movq %rdx, %r11
    #get the length of the strings
    movq %rsi, %rdi
    call pstrlen
    movq %rax, %r12
    movq %rdx, %rdi
    call pstrlen
    movq %rax, %r13

    movq $ch_34, %rdi
    #now need place in the stack to save i and j
    subq $8, %rsp
    #assuming we are getting integers
    movq -8(%rbp), %rsi
    movq -4(%rbp), %rdx
    xorq %rax, %rax
    call scanf
    #now we have the values in the stack, we can use them
    movq %r11, %rdi
    movq %r10, %rsi
    movq -8(%rbp), %rdx
    movq -4(%rbp), %rcx
    call pstrijcpy

    #now we can print the result
    movq $ch_33, %rdi
    movq %r12, %rsi
    movq %r10, %rdx
    xorq %rax, %rax
    call printf

    movq $ch_33, %rdi
    movq %r13, %rsi
    movq %r11, %rdx
    xorq %rax, %rax
    call printf
    jmp .end

.invalid:
    movq $gg, %rdi
    xorq %rax, %rax
    call printf

.end:
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    