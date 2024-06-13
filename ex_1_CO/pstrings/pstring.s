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
    # If we're at the end of the string, exit
    cmpb $0x0, (%rdi)
    je end1
    # Read byte from string
  
    cmpb $'a', (%rdi)
    jl maybe_upper
    cmpb $'z', (%rdi)
    jg next1
    movb (%rdi), %al
    add $-0x20, %al
    movb %al, (%rdi)
    jmp next1

maybe_upper:
    cmpb $'A', (%rdi)
    jl next1
    cmpb $'Z', (%rdi)
    jg next1
    movb (%rdi), %al
    add $0x20, %al
    movb %al, (%rdi)
    jmp next1
    
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
