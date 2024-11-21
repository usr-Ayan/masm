.model small
.stack 100h

.data
space db ' $'
.code

main proc
	mov ax,@data
	mov ds,ax

	mov bx,65
	mov cx, 1
	label1:
		cmp bl,67
		je skip
		mov dl,bl
		mov ah,02h
		int 21h

		lea  dx,space
		mov ah,09h
		int 21h
		skip:
		inc cx
		inc bx
		cmp cx,27
		jne label1
	mov ah,4ch
	int 21h
main endp
end main

		