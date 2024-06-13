// the implementation of the functions 
// all good. 
// pstrlen - length of the string
// swapCase - every capital letter becomes small and vice versa
// pstrijcpy - Given pointers to two Pstrings, and two indices, the function copies src[i:j]
// into dst[i:j] and returns the pointer to dst. If either i or j are invalid given src and dst
// sizes, no changes should be made to dst, and the following message message should
// be printed: "invalid input!\n".

// OF CURSE, no use of the standard library functions is allowed.

// useing the stack is basically the only way to do this (and the only way allowed).

//is there suppose to be main?

//if want, create here a rodata with the gap of ascii between the capital and small letters, wich is 32, and in hex is 0x20
.extern printf
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


.global swapCase
.type swapCase, @function
swapCase:
    # calle, backup
    pushq %rbp
    movq %rsp, %rbp

    # as before, rdi is the pstrign
    movq %rdi, %r13 # save the pointer
    incq %rdi # we want the string, not the char

loop1:
    # Read byte from string
    movb (%rdi), %al

    # If we're at the end of the string, exit
    cmpb $0x0, %al
    je .end1
    cmp al,'a'
    jb maybe_upper
    cmp al,'z'
    ja next2
    sub al,0x20
    //need to look on this again
    movb al, (%rdi)
    jne .next

maybe_upper:
    cmp al,'A'
    jb next2
    cmp al,'Z'
    ja next2
    add al,0x20
    movb al, (%rdi)
    jne .next
next2:
    # Increment the pointer, and continue to next iteration
    incq %rdi
    jmp loop1

end2:
    movq %r13, %rax
    movq %rbp, %rsp
    popq %rbp
    ret


.global pstrijcpy
.type pstrijcpy, @function
pstrijcpy:
