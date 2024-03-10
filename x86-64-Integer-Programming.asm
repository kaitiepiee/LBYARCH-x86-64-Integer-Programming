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
    input dq 0x0000000000000000
    count dq 0x0000000000000000
    sum db 0x00
    m db 0x00


section .text
    global main
    
main:
    PRINT_STRING msg_input
    GET_DEC 8, input
    mov rax, [input]
    mov rcx, 0 ;necessary or digit count will be one higher
    PRINT_DEC 8, rax
    jmp check_input

check_input:
    ;Check if input is a positive integer
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
    mov rcx, [count]  ;length of input number
    mov rdx, [m]      ;m value
    xor r8, r8        ;initialize counter
    
    
;Check if a number is positive  
is_positive:
    cmp rsi, 0
    jle .negative
    mov rax, 1
    PRINT_STRING "positive"
    jmp count_digits ;count digits if input is valid
 .negative:
    PRINT_STRING "Invalid input"
    xor rax, rax ; TODO: Ask if user wants to continue, if yes jmp main
    ret

count_digits: 
    cmp rax, 0
    je post_count     ;ends when number is 0 after loop

    inc rcx           ;increment the number of digits  
    mov rdx, 0  ;set remainder to 0                
    mov rbx, 10 ;set divisor to 10             
    idiv rbx    ;divide rax by 10             
                ;TODO: add something here to store the digits (digits are in rdx)
    jmp count_digits
 
post_count:   
    mov [count], rcx
  
  
  
  
  
  
  
  
;Check if the input number is an Armstrong number  
is_armstrong:
    mov rax, rdi      ; store input number
    xor rbx, rbx      ; clear sum
    mov rcx, [m]      ; get m value
    mov rdx, [length] ; get length of number
