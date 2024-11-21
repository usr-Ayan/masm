.model small
.stack 100h

.data
    newline db 10, 13, '$'

.code 
main proc
    ; Set up data segment
    mov ax, @data
    mov ds, ax

    ; Reset ax
    mov ax, 00h

input:
    ; Read a character
    mov ah, 01h
    int 21h
    ; The character is now in AL

convert:
    ; Convert case by toggling bit if needed
    xor al, 20h
    mov dl, al ; Store the converted character in DL for output



output:
    ; Print the character in DL
    mov ah, 02h
    int 21h

print_newline:
    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; End program
    mov ah, 4Ch
    int 21h

main endp
end main
