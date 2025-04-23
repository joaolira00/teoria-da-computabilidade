section .data
prompt      db "Insira um numero: ", 0
prompt_len  equ $ - prompt
invalid_msg db "Numero invalido! Tente novamente.", 10, 0
invalid_len equ $ - invalid_msg
num_buf     db '0','0',' ', 0
newline     db 10, 0
section .bss
input_buf   resb 3
section .text
global _start
_start:
read_input:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, prompt
    mov     rdx, prompt_len
    syscall
    mov     rax, 0
    mov     rdi, 0
    mov     rsi, input_buf
    mov     rdx, 3
    syscall
    mov     al, [input_buf]
    cmp     al, '0'
    jl      invalid
    cmp     al, '9'
    jg      invalid
    sub     al, '0'
    movzx   rax, al
    mov     dl, [input_buf+1]
    cmp     dl, 10
    je      got_num
    mov     rcx, 10
    imul    rax, rcx
    movzx   rcx, dl
    cmp     cl, '0'
    jl      invalid
    cmp     cl, '9'
    jg      invalid
    sub     cl, '0'
    add     rax, rcx

got_num:
    cmp     rax, 11
    ja      invalid
    mov     rcx, rax
    jmp     compute_seq

invalid:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, invalid_msg
    mov     rdx, invalid_len
    syscall
    jmp     read_input

print_num:
    push    rax
    push    rbx
    push    rcx
    push    rdx
    mov     rbx, rax
    xor     rdx, rdx
    mov     rcx, 10
    div     rcx
    add     al, '0'
    add     dl, '0'
    mov     [num_buf], al
    mov     [num_buf+1], dl
    mov     byte [num_buf+2], ' '
    mov     rax, 1
    mov     rdi, 1
    lea     rsi, [num_buf]
    mov     rdx, 3
    syscall
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rax
    ret

compute_seq:
    xor     rdx, rdx
    xor     rax, rax
    mov     rbx, 1

seq_loop:
    cmp     rdx, rcx
    jg      seq_done
    call    print_num
    mov     rsi, rax
    mov     rax, rbx
    add     rbx, rsi
    inc     rdx
    jmp     seq_loop

seq_done:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, newline
    mov     rdx, 1
    syscall
    mov     rax, 60
    xor     rdi, rdi
    syscall