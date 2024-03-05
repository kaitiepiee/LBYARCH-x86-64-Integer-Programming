; S15 Group 6: Hans Coo and Kaitlyn Tighe

;An "Armstrong" number is define as "m-digit positive number equal to sum of the m-th powers of their digits. "
;For Example: Number 1634 is an Armstrong number since 14+64+34+44 = 1634
;Write a working x86-64 assembly program that accepts as input a positive integer and determine if the number is an "Armstrong" number.
;Required to use at least a functional x86-64 register.
;Input: prompt user for an input. Input should be a positive integer. Error checking: invalid input. If error exists, output an appropriate error message and input again.
;Process: Check if the input is an Armstrong number
;Output: List the m-th power of the digits in correct order, the sum and whether it is an Armstrong number.
;Prompt the user whether the program will be executed again.


%include "io64.inc"

section .data
    msg_input db "Input Number: ",0
    msg_result db "m-th power of each digits:",0
    msg_sum_of_digits db "Sum of the m-th power digits: ",0
    msg_armstrong db "Armstrong Number: ", 0
    msg_continue db "Do you want to continue (Y/N)? ",0
    msg_invalid_input db "Error: Invalid input. Please enter a positive integer.",0
    
    comma db ", ",0
    length db 0x00
    input dd 0x00000000
    sum db 0x00
    m db 0x00


section .text
    global main
    
main:
    PRINT_STRING msg_input
    GET_STRING input, 32
    mov eax, [input]
    jmp check_input

check_input:
    ;Check if input is a positive integer
    mov rdi, input
    jmp str_to_int
    mov rsi, rax
    jmp is_positive
    cmp rax, 0
    je invalid_input
    
    ;If positive, continue
    mov rsi, input
    jmp str_to_int
    mov rdi, rax
    jmp is_armstrong
    

invalid_input:
    PRINT_STRING msg_invalid_input
    NEWLINE
    jmp main
    
;Print the m-th power of each digit
print_armstrong_digits:
    mov rdi, rax      ;input number
    mov rcx, [length] ;length of input number
    mov rdx, [m]      ;m value
    xor r8, r8        ;initialize counter
    

;Convert a string to an integer
str_to_int:
    xor rax, rax ;result
    xor rbx, rbx ;digit
    
;Check if a number is positive  
is_positive:
    cmp rdi, 0
    jle .negative
    mov rax, 1
    ret
 .negative:
    xor rax, rax
    ret
  
;Check if the input number is an Armstrong number  
is_armstrong:
    mov rax, rdi      ; store input number
    xor rbx, rbx      ; clear sum
    mov rcx, [m]      ; get m value
    mov rdx, [length] ; get length of number