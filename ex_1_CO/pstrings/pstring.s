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
.section .text
.global pstrlen
.type pstrlen, @function
pstrlen:
    //assuming that the arg is currently in rdi
    xorq %rax, %rax
loop1:
    #straight from the tirgul
    # Read byte from string
    movb (%rdi), %al

    # If we're at the end of the string, exit
    cmpb $0x0, %al
    je .end1
    jne .next
next1:
    # Increment the pointer, and continue to next iteration
    incq %rdi
    inc %rax
    jmp loop1

end1:
    ret


.global swapCase
.type swapCase, @function
swapCase:
    //assuming that the arg is currently in rdi
    xorq %rax, %rax
loop2:
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
    inc %rax
    jmp loop1

end2:
    ret


.global pstrijcpy
.type pstrijcpy, @function
pstrijcpy:
