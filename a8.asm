.model small
.stack 100h
.data
    prompt1 db 13,10,"Enter the number of elements (1-9): $"
    prompt2 db 13,10,"Enter an element (0-9): $"
    msgMax db 13,10,"Maximum: $"
    msgMin db 13,10,"Minimum: $"
    newline db 13,10,'$'
    numElements db 0
    arr db 10 dup (?) ; Array to hold up to 10 elements
    max db 0
    min db 9

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Get number of elements from user
    lea dx, prompt1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov numElements, al

    ; Input elements into array
    mov cl, numElements
    lea si, arr
input_loop:
    lea dx, prompt2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov [si], al
    inc si
    loop input_loop

    ; Initialize max and min
    mov al, 0
    mov [max], al
    mov al, 9
    mov [min], al

    ; Find maximum and minimum
    lea si, arr
    mov cl, numElements
find_values:
    mov al, [si]
    ; Check for maximum
    cmp al, [max]
    jle check_min
    mov [max], al

check_min:
    ; Check for minimum
    cmp al, [min]
    jge done
    mov [min], al

done:
    inc si
    loop find_values

    ; Print maximum
    lea dx, msgMax
    mov ah, 09h
    int 21h
    mov al, [max]
    call print_number
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Print minimum
    lea dx, msgMin
    mov ah, 09h
    int 21h
    mov al, [min]
    call print_number
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp

; Helper procedure to print a number
print_number proc
    mov ah, 02h
    add al, '0'
    mov dl, al
    int 21h
    ret
print_number endp

end main

