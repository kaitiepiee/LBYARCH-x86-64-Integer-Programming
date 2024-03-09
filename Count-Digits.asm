%include "io64.inc"
section .text
global main
main:
    ;write your code here
    GET_DEC 8, rax
    mov rcx, 0  ;necessary or digit count will be one higher
    
count_digits:
    cmp rax, 0
    je done     ;ends when number is 0 after loop

    inc rcx     ;increment the number of digits  
    mov rdx, 0  ;set remainder to 0
    mov rbx, 10 ;set divisor to 10
    idiv rbx    ;divide rax by 10
                ;can add something here to store the digits (in rdx)
    jmp count_digits

done:
    PRINT_DEC 8, rcx
    xor rax, rax
    ret