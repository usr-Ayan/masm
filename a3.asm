.model small
.stack 100h

.data
    prompt db 'Enter a 16-bit number: $'
    msg db 0Dh, 0Ah, 'The number you entered is: $'
    num1 dw ?               ; 16-bit number to store the converted input
    num2 dw ?
    newline db 0Dh, 0Ah, '$'  ; Newline for formatting

.code
input_num proc
    mov bx,0h
    mov cl,4h
    input:
        mov ah,01h
        int 21h
        cmp al,0dh
        je end1
        shl bx,cl
        cmp al,57
        jg letter
        sub al,48
        jmp shift1
        letter:
            sub al,55
        shift1:
        or bl,al
        jmp input
    end1:
    ret
input_num endp
print_num proc
    mov cl,4h
    mov ch,4h
    print:
        rol bx,cl
        mov al,bl
        and al,0fh
        cmp al,09h
        jg letter2
        add al,48
        jmp shift2
        letter2:
            add al,55
        shift2:
        mov ah,02h
        mov dl,al
        int 21h
        dec ch
        jnz print
    end2:
    ret
print_num endp
main proc
    ; Set up data segment
    mov ax, @data
    mov ds, ax

    ; Display prompt message
    lea dx, prompt
    mov ah, 09h
    int 21h
    call input_num
    mov num1,bx

    lea dx, prompt
    mov ah, 09h
    int 21h
    call input_num
    mov num2,bx

    lea dx, msg
    mov ah, 09h
    int 21h
    mov bx,num1
    add bx,num2
    jnc shift3
    mov ah,02h
    mov dl,'1'
    int 21h
    shift3:
    call print_num

    mov ah,4ch
    int 21h
main endp
end main

