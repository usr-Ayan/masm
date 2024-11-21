.model small
.stack 300h
.data
msg1 db 10,13,'ENTER 1ST NUMBER: $'
msg2 db 10,13,'ENTER 2ND NUMBER: $'
msg3 db 10,13,'THE RESULT AFTER ADDITION IS: $'
msg4 db 10,13,'THE RESULT AFTER SUBTRACTION IS: $'
space db ' $'
endl db 10,13,'$'

val1 dw ?
val2 dw ?

.code
print macro msg
	push ax
	push dx
	mov ah, 09h
	lea dx, msg
	int 21h
	pop dx
	pop ax
endm

main proc
	mov ax,@data
	mov ds,ax
	
	start:
	
	print msg1
	
	call readnum
	mov val1, ax

	print msg2

	call readnum
	mov val2, ax

	print msg3
        mov ax, val1
        mov bx, val2
        add ax,bx
	call writenum

        print msg4
        mov ax, val1
        mov bx, val2
        sub ax,bx
        call writenum
	
	exit:
    mov ah, 4ch
    int 21h

main endp

readnum proc near
	
	push bx
	push cx
	mov cx,0ah
	mov bx,00h
	loopnum: 
		mov ah,01h
		int 21h
		cmp al,'0'
		jb skip
		cmp al,'9'
		ja skip
		sub al,'0'
		push ax
		mov ax,bx
		mul cx
		mov bx,ax
		pop ax
		mov ah,00h
		add bx,ax
	jmp loopnum
	
	skip:
	mov ax,bx
	pop cx
	pop bx
	ret
readnum endp

writenum proc near

	push ax
	push bx                        
	push cx                        
	push dx                        

	xor cx, cx
	mov bx, 0ah                     

	@output:                       
		xor dx, dx                   
		div bx                      
		push dx                   
		inc cx                       
		or ax, ax                    
	jne @output                    

	mov ah, 02h                      

	@display:                      
		pop dx                      
		or dl, 30h                 
		int 21h                      
	loop @display                  

	pop dx                         
	pop cx                         
	pop bx 
	pop ax

	ret                            
writenum endp

end main

