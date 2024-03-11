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
    msg_result db "m-th power of each digits :",0
    msg_sum_of_digits db "Sum of the m-th power digits: ",0
    msg_armstrong db "Armstrong Number: ", 0
    msg_continue db "Do you want to continue (Y/N)? ",0
    msg_invalid_input db "Error: Invalid input.",0
    
    comma db ", ",0
    length db 0x00
    input dq 0x0000000000000000
    count dq 0x0000000000000000
    sum db 0x00
    m db 0x00
    digits dq 10 dup(0)  ; 10 digit array
    response dq 0x0000000000000000


section .text
    global main
    
main:
    PRINT_STRING msg_input
    GET_DEC 8, input
    mov rax, [input]
    mov rcx, 0 ;necessary or digit count will be one higher
    mov r10, 0 ; store the sum
    PRINT_DEC 8, rax
    NEWLINE
    jmp check_input

check_input:
    ;Check if input is a positive integer
    mov rsi, rax
    jmp is_positive
    cmp rax, 0
    je invalid_input
    
    

invalid_input:
    PRINT_STRING msg_invalid_input
    NEWLINE
    jmp continue
    
;Print the m-th power of each digit
print_armstrong_digits:
    mov rdi, rax      ;input number
    mov rcx, [count]  ;length of input number
    mov rdx, [m]      ;m value
    xor r8, r8        ;initialize counter
    
    
;Check if a number is positive  
is_positive:
    cmp rsi, 0
    je invalid_input
    jl .negative
    jmp count_digits ;count digits if input is valid
 .negative:
    PRINT_STRING "Error: negative number input"
    jmp continue
    xor rax, rax 
    ret

count_digits: 
    cmp rax, 0
    je post_count     ;ends when number is 0 after loop

    inc rcx           ;increment the number of digits  
    mov rdx, 0  ;set remainder to 0                
    mov rbx, 10 ;set divisor to 10             
    idiv rbx    ;divide rax by 10   
    mov rsi, digits             ; load the address of the digits array
    mov rdi, rcx                ; Use rcx as an index to access the array
    mov [rsi + rdi*8 - 8], rdx  ; Store the digit at the corresponding index          

    jmp count_digits

post_count:   

    mov [count], rcx      ;input is in input ;count has the number of digits ;digits has the digits in reverse order
    
    PRINT_STRING msg_result
    
outer_loop:
    cmp rcx, 0
    jle check_armstrong
    dec rcx
    mov r9, 1              ;store the power
    mov r11, [count]       ;store the counter 3

inner_loop:
    cmp r11, 0 ;loops count num of times
    jle add_to_sum
    dec r11 
    imul r9, [digits + rcx*8]
    jmp inner_loop
     
add_to_sum:
    PRINT_DEC 8, r9
    add r10, r9
    
    cmp rcx, 0
    je no_comma
    
pcomma:
    PRINT_STRING ", "
    
no_comma:
    jmp outer_loop
    
check_armstrong:
    mov rax, [input]
    cmp rax, r10
    NEWLINE
    PRINT_STRING msg_sum_of_digits
    PRINT_DEC 8, r10
    je is_armstrong
    jne not_armstrong

is_armstrong:
    NEWLINE
    PRINT_STRING "Armstrong Number: Yes"
    jmp continue
    
not_armstrong:
    NEWLINE
    PRINT_STRING "Armstrong Number: No"
    jmp continue
    
continue:
    NEWLINE
    PRINT_STRING msg_continue
    GET_CHAR response
    mov rsi, response
    mov al, byte [rsi]
    cmp al, 'Y'
    je main
    jne end

end:
    xor rax, rax 
    ret
