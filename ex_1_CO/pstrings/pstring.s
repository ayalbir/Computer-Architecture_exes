/* 214104226 Ayal Birenstock */
.extern printf
.section .rodata
inavlid: .string "invalid input!\n"
.section .text
.global pstrlen
.type pstrlen, @function
pstrlen:
    # calle, backup
    pushq %rbp
    movq %rsp, %rbp

    # the first arg inside the pstring is the char, said to be at max size of 254
    movb (%rdi), %al

    movq %rbp, %rsp
    popq %rbp
    ret


.globl swapCase
.type   swapCase, @function
swapCase:
    pushq %rbp      # callee conv. backup RBP and set RBP to Activation Frame
    movq %rsp, %rbp
    movq %rdi, %r8 # save the pointer to the pstring

    //the problem: for some reason al is the size of the string, and rdi isnt increased to point on the string.

    //rdi is an arg to the func, it's a pointer to pstring. we don't want to loose to pointer, but also, we want the damn string to change! what can we do? we already saved the pointer in r8, so what the hell, y this isnt working??

    incq %rdi
    jmp .loop

.loop:
    cmpb $0x0,(%rdi)   # if the char is null nothing to change
    je exit
    cmpb $'A',(%rdi)    # check if maybe it is not letters
    jl .next
    cmpb $'z',(%rdi)    # check if it is not letters
    jg .next    
    cmpb $'a',(%rdi)     # check if it is lower case
    jge  upperCase    # if it is lower case then change to upper
    movb (%rdi), %al
    addb $0x20, %al
    movb %al, (%rdi) # change to lower case
    jmp .next
upperCase:
    movb (%rdi), %al
    addb $-0x20, %al
    movb %al, (%rdi) # change to upper case
    jmp .next

.next:
    incq %rdi
    jmp .loop
exit:
    movq %r8, %rax # return the pointer to the string
    movq %rbp, %rsp # callee conv. free activation frame and restore main frame
    popq %rbp
    ret


.global pstrijcpy
.type pstrijcpy, @function
pstrijcpy:
    #the args are rdi, rsi, rdx, rcx
    #the meaning: dst, src, i  , j
    # calle, backup
    pushq %rbp
    movq %rsp, %rbp
    movq %rdi, %r8
    addq %rdx, %rsi
    addq %rdx, %rdi
    incq %rdi
    incq %rsi
    jmp .loop2
    
.loop2:
    movb (%rsi), %al
    movb %al,(%rdi)
    incq %rsi
    incq %rdi
    incq %rdx
    
    # check if i \le j
    cmpq %rdx, %rcx
    jl end2
    jmp .loop2

end2:
    movq %r11, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
    