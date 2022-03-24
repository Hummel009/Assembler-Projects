org 100h
;the sum of 0+ elements with indexes mod 2 = 1

;====== Start ======;
start:
        mov ah, 09h
        mov dx, str1
        int 21h

        mov cx, 2

cycle1:
        mov bx, cx
        mov ax, [nums+bx]
        call intToStrAndDisp
                
        mov ah, 02h
        mov dx, ' '
        int 21h
                
        add cx, 2
        cmp cx, [bytes]

jbe cycle1

;====== Calc the sum ======;
        mov cx, 2
cycle2:

        mov bx, cx
        mov ax, [nums+bx]
        add [plus], ax

        add cx, 4
        cmp cx, [bytes]

jbe cycle2


;====== Display the sum ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [plus]
        call intToStrAndDisp

        mov ah, 08h
        int 21h
        
ret

;====== IntToStrAndDisp ======;
intToStrAndDisp:
        aam
        add ax, '00'
        mov dl, ah
        mov dh, al
                
        mov ah, 02h
        int 21h
                
        mov dl, dh
        int 21h
ret

;====== Variables ======;
        str1 db "Array: $"
        str3 db "The sum of 0+ elements: $"
        nums dw '0', 1, 2, 3, 4, 7, 6, 7, 8, 9
        bytes dw 18
        newLine db 13, 10, '$'

;====== Temp variables ======;
        plus dw 0