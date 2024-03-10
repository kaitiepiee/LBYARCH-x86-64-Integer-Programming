%include "io64.inc"

section .data
    count dq 0x0000000000000000
    digits dq 10 dup(0)  ; 10 digit array

section .text
global main

main:
    ; Get user input
    GET_DEC 8, rax

    ; Initialize variables
    mov rcx, 0                  ; Initialize digit count to 0

count_digits:
    cmp rax, 0
    je done_counting           ; Ends when number is 0 after loop

    inc rcx     ;increment the number of digits  
    mov rdx, 0  ;set remainder to 0                
    mov rbx, 10 ;set divisor to 10             
    idiv rbx    ;divide rax by 10 
    
    ; Store the digit in the array
    mov rsi, digits             ; load the address of the digits array
    mov rdi, rcx                ; Use rcx as an index to access the array
    mov [rsi + rdi*8 - 8], rdx  ; Store the digit at the corresponding index

    jmp count_digits

done_counting:
    ; Print the count of digits
    mov [count], rcx
    PRINT_STRING "Number of digits: "
    PRINT_DEC 8, rcx
    NEWLINE
    PRINT_STRING "Digits: "

    ; Print each digit from the array (right to left)

    
    PRINT_DEC 8, [digits_array] ; I only hardcoded 4 digits
    PRINT_STRING ", "
    PRINT_DEC 8, [digits + 8]
    PRINT_STRING ", "
    PRINT_DEC 8, [digits + 16]
    PRINT_STRING ", "
    PRINT_DEC 8, [digits + 24]
    
    xor rax, rax
    ret
