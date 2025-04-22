section .data
    prompt      db "Insira um numero: ", 0
    prompt_len  equ $ - prompt

    invalid_msg db "Numero invalido! Tente novamente.", 10, 0
    invalid_len equ $ - invalid_msg

    input_buf   times 3 db 0
    result      db '0','0'

section .text
    global _start

_start:
read_input:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, input_buf
    mov edx, 3
    int 0x80

    movzx eax, byte [input_buf]
    cmp al, '0'
    jl invalid
    cmp al, '9'
    jg invalid
    sub al, '0'
    movzx eax, eax

    mov dl, [input_buf+1]
    cmp dl, 10
    je got_number_one

    mov ecx, 10
    mul ecx
    movzx ecx, byte [input_buf+1]
    cmp cl, '0'
    jl invalid
    cmp cl, '9'
    jg invalid
    sub cl, '0'
    add eax, ecx
    jmp got_number

got_number_one:
    movzx eax, byte [input_buf]
    sub al, '0'

got_number:
    cmp eax, 11
    jg invalid

    mov ecx, eax
    jmp compute_fib

invalid:
    mov eax, 4
    mov ebx, 1
    mov ecx, invalid_msg
    mov edx, invalid_len
    int 0x80
    jmp read_input

compute_fib:
    cmp ecx, 0
    je fib_zero
    cmp ecx, 1
    je fib_one

    mov eax, 0
    mov ebx, 1
    mov edx, 2

fib_loop:
    cmp edx, ecx
    jg fib_end

    mov esi, eax
    add esi, ebx
    mov eax, ebx
    mov ebx, esi
    inc edx
    jmp fib_loop

fib_zero:
    mov ebx, 0
    jmp print_result

fib_one:
    mov ebx, 1
    jmp print_result

fib_end:
    jmp print_result


print_result:
    mov eax, ebx
    xor edx, edx
    mov ecx, 10
    div ecx

    add al, '0'
    add dl, '0'
    mov [result],  al
    mov [result+1], dl

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 2
    int 0x80


    mov eax, 1
    xor ebx, ebx
    int 0x80
