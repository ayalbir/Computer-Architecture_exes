/* 214104226 Ayal Birenstock */
.extern printf
.section .rodata
inavlid: .string "invaild input!\n"
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
    movq %rdi, %r10 # save the pointer
    incq %rdi # we want the string, not the char

loop1:
    # Read byte from string
    movb (%rdi), %al

    # If we're at the end of the string, exit
    cmpb $0x0, %al
    je end1
    cmp %al,'a'
    jb maybe_upper
    cmp %al,'z'
    ja next1
    sub $0x20, %al
    //need to look on this again
    movb %al, (%rdi)
    jne next1

maybe_upper:
    cmp %al,'A'
    jb next1
    cmp %al,'Z'
    ja next1
    add $0x20, %al
    movb %al, (%rdi)
    jne next1
    
next1:
    # Increment the pointer, and continue to next iteration
    incq %rdi
    jmp loop1

end1:
    movq %r10, %rax
    movq %rbp, %rsp
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
    #first, we will check if the input is vaild
    #we need: 0 \leq i,j \leq |src|, |dst|
    #q, what if (and probably will) j < i?
    #we know that the sizes are saved in the first arg in the pstring
    #try:
    cmp $0, %rdx
    // we need to jump if rdx < 0
    jge wrng_end
    cmp $0, %rcx
    // same
    jge wrng_end
    cmp (%rdi), %rdx
    // we need to jump if rdx > (%rdi)
    jl wrng_end
    cmp (%rdi), %rcx
    jl wrng_end
    cmp (%rsi), %rdx
    jl wrng_end
    cmp (%rsi), %rcx
    jl wrng_end

    movq %rdi, %r11 #save the pointer
    movq %rsi, %r12 #save the pointer

    #now advance to the string itself
    incq %rdi
    incq %rsi
    # now advanced to i in the string
    addq %rdx, %rdi
    addq %rdx, %rsi

loop2:
    # replacr the char in dst with src
    movb (%rsi), %al
    movb %al, (%rdi)
    incq %rdi
    incq %rsi
    # advance to the next char, and check if we are done
    incq %rdx
    cmp %rcx, %rdx
    jl loop2
    jmp end2



wrng_end:
    movq $inavlid, %rdi
    xorq %rax, %rax
    call printf
    movq %rbp, %rsp
    popq %rbp
    ret

end2:
    movq %r11, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

