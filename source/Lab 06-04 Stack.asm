org 100h
;CALCULATE FORMULA WITH 16-BIT NUMBERS USING CALL WITH GLOBAL PARAMETERS

;====== START ======;

        mov ah, 09h
        mov dx, writeln2
        int 21h

        mov ah, 0ah
        mov dx, readln2
        int 21h

        mov ah, 09h
        mov dx, newLine
        int 21h

;====== STR TO INT ======;

        mov bx, 0
        mov bl, [readln2+2]
        sub bl, '0'

;====== PREPARING CALL ======;         \
        push bx

        cmp bx, 0
        jl @F

        call operationsPos
        jmp show

        @@:
        call operationsNeg

;====== SHOW ======;
show:
        call intToStrAndDisp

        mov ah, 08h
        int 21h

ret

;====== OPERATIONS ======;
operationsPos:
        push bp
        mov bp, sp
        mov ax, [bp+4]
        mov bx, [bp+4]
        mul bx
        sub ax, 3
        pop bp
retn 2

operationsNeg:
        push bp
        mov bp, sp
        mov ax, [bp+4]
        mov bx, [bp+4]
        mul bx
        mov cx, ax
        mov ax, 5
        sub ax, cx
        pop bp
retn 2

;====== CONVERT ======;
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

;====== VARIABLES ======;
        writeln2 db "Enter the number D: $"
        newLine db 13, 10, '$'
        readln2 db 2, 0, 2 dup "$"