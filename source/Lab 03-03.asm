org 100h
;find the positions of two duplicates in the array

;====== Start ======;
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

;====== First loop ======;
        mov cx, [bytes]            
cycle2:

        mov [savedI], cx              

        ;====== Second loop ======;
        mov cx, [bytes]             

        cycle3:
                mov [savedJ], cx     

                mov bx, [savedI]
                mov dx, [nums+bx]
                mov [savedAI], dx     

                mov bx, [savedJ]
                mov dx, [nums+bx]
                mov [savedAJ], dx    

                mov bx, [savedI]
                cmp bx, [savedJ]
                je @F           

                mov dx, [savedAI]
                cmp dx, [savedAJ]
                jne @F        

        ;====== Find real pos ======;
                mov ax, [savedI]
                mov bl, 2
                div bl
                mov [neededI], ax

                mov ax, [savedJ]
                mov bl, 2
                div bl
                mov [neededJ], ax

                dec cx            

        @@:
        loop cycle3

        mov cx, [savedI]            
        dec cx                      

loop cycle2

;====== Display first duplicate ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str2
        int 21h

        mov ax, [neededI]
        call intToStrAndDisp

;====== Display second duplicate ======;
        mov ah, 09h
        mov dx, newLine
        int 21h

        mov ah, 09h
        mov dx, str3
        int 21h

        mov ax, [neededJ]
        call intToStrAndDisp

;====== Do not exit ======;
        mov ah, 08h
        int 21h
        
ret

;====== IntToStr ======;
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
        str2 db "Dup Index 1: $" 
        str3 db "Dup Index 2: $" 
        nums dw '0', 59, 8, 7, 6, 5, 59, 3, 2, 1  
        bytes dw 18                                
        length dw 9                                
        newLine db 13, 10, '$'
        neededI dw 0
        neededJ dw 0
        savedI dw 0
        savedJ dw 0
        savedAI dw 0
        savedAJ dw 0