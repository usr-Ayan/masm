.model small
.stack 100h
.data
    prompt1 db 13,10,"Enter the number of elements (1-9): $"
    prompt2 db 13,10,"Enter an element (0-9): $"
    msgMax db 13,10,"Second Maximum: $"
    msgMin db 13,10,"Second Minimum: $"
    newline db 13,10,'$'
    nsz dw 0
    arr dw 100 dup (?) ; Array to hold up to 10 elements
    max1 dw ?
    max2 dw ?
    min1 dw ?
    min2 dw ?

.code

input_num proc
    push cx
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
    pop cx
    ret
input_num endp
print_num proc
    push cx
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
    pop cx
    ret
print_num endp
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Get number of elements from user
    lea dx, prompt1
    mov ah, 09h
    int 21h

    call input_num
    mov nsz,bx

    mov cx,nsz
    lea di,arr
    input_loop:
        lea dx, prompt2
        mov ah, 09h
        int 21h
        call input_num
        mov word ptr [di],bx
        add di,2
    loop input_loop

    lea di,arr
    mov ax,0FFFFh
    mov max1,0
    mov max2,0
    mov min1,ax
    mov min2,ax
    mov cx,nsz
    loop2:
        mov bx,word ptr [di]
        cmp bx,max1
        ja shift_1
        cmp bx,max2
        ja shift_2
        jmp shift3
        shift_2:
            mov max2,bx
        jmp shift3
        shift_1:
            mov dx,max1
            mov max2,dx
            mov max1,bx
        shift3:
        cmp min1,bx
        ja shift4
        cmp min2,bx
        ja shift5
        jmp shift6
        shift5:
            mov min2,bx
        jmp shift6
        shift4:
            mov dx,min1
            mov min2,dx
            mov min1,bx
        shift6:
        add di,2
    loop loop2

    lea dx,msgMax
    mov ah,09h
    int 21h
    mov bx,max2
    call print_num

    lea dx,msgMin
    mov ah,09h
    int 21h
    mov bx,min2
    call print_num

    mov ah,4ch
    int 21h

main endp
end main

