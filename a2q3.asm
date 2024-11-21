.model small
.data
    open db "($"
    close db ")$"
    space db " $"
    newline db 10,"$"
    val1 dw ?
    val2 dw ?

.code
print macro msg
    push ax
    push dx
    lea dx,msg
    mov ah,09h
    int 21h
    pop dx
    pop ax
ENDM

main proc
    mov ax,@data
    mov ds,ax

    mov ax,64h
    mov bx,64h
    label1:
    print open
    call write_num
    print space
    mov val1,ax
    mov ax,bx
    mov cx,val1
    sub ax,cx
    call write_num
    print close
    print space
    mov ax,val1
    sub ax,2
    cmp ax,0
    jne label1

    print open
    call write_num
    print space
    mov ax,bx
    call write_num
    print close

    mov ah,4ch
    int 21h
endp main

write_num proc
push ax
push bx
push cx
push dx
xor cx,cx
mov bx,0ah
loop1:
xor dx,dx
div bx
push dx
inc cx
or ax,ax
jne loop1

mov ah,02h
@display:
pop dx
or dx,48
int 21h
loop @display
pop dx
pop cx
pop bx
pop ax 
ret
write_num endp
end main





