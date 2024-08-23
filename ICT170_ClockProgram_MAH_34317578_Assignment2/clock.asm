;34317578 Jaeden Mah
TITLE Clock
.MODEL LARGE
.STACK 200H

.DATA
h DB 0
m DB 0
s DB 0

Sdigit1 DB 0
Sdigit2 DB 0
Mdigit1 DB 0
Mdigit2 DB 0
Hdigit1 DB 0
Hdigit2 DB 0

b1 DB 0
counter DW 0

msg db "Enter a number (0-9): $"
msg1 db "Above is the display format. Press any key$"


.CODE
MAIN PROC Far

; initialize DS
MOV AX, @DATA
MOV DS, AX

mov ah, 09h  ; Required ms-dos function
lea dx, msg  ; Address of the text to print
int 21h 


MOV AH, 1 ; read a number with echo
INT 21H

SUB AL, 30H ; convert number from ASCII
XOR AH, AH;

MOV s, AL; second

mov DL, 10      ;printing new line
    mov AH, 02h
    int 21h
    mov DL, 13
    mov AH, 02h
    int 21h

;;;;;;;;;;;;;;;;;print hour

MOV AL, h;
XOR AH, AH; 

MOV b1, 10 ;splits remainder into 2 digits to display hours
DIV b1

MOV Hdigit1, AL
MOV Hdigit2, AH

MOV DL, Hdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Hdigit2
ADD DL, 30h
int 21h


MOV DL, ':'
mov AH, 02h
int 21h

;;;;;;;;;;;;;;;;;print minute

MOV AL, m;
XOR AH, AH; 

MOV b1, 10 ;splits remainder into 2 digits to display minutes
DIV b1

MOV Mdigit1, AL
MOV Mdigit2, AH

MOV DL, Mdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Mdigit2
ADD DL, 30h
int 21h


MOV DL, ':'
mov AH, 02h
int 21h

;;;;;;;;;;;;;;;;;;print second
MOV AL, s;
XOR AH, AH; 

MOV b1, 10 ;splits remainder into 2 digits to display seconds
DIV b1

MOV Sdigit1, AL
MOV Sdigit2, AH

MOV DL, Sdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Sdigit2
ADD DL, 30h
int 21h


mov DL, 10      ;printing new line
    mov AH, 02h
    int 21h
    mov DL, 13
    mov AH, 02h
    int 21h

;; DISPLAY Formatting 
mov ah, 09h  ; Required ms-dos function
lea dx, msg1  ; Address of the text to print
int 21h 


MOV AH, 1 ; read a number with echo
INT 21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;MOV CX, 4000
MOV counter, 0;




;;;;;;;;;;;;;beginning of main loop
mainLOOP:


MOV CX, 40000 

Delay: ; just to obtain a slow speed
XOR AX, AX	
Loop Delay


;;;;;;;;;;;;;;;;;;does calculations for seconds first
INC s;  second

MOV AL, s;
XOR AH, AH; AX copies s

MOV b1, 60
DIV b1; checking for 60 s

ADD m, AL  ;this increments minutes if seconds/60 is quotient of 1

MOV s, AH ;uses remainder to display seconds

MOV AL, s;
XOR AH, AH; 


MOV b1, 10 ;splits remainder into 2 digits to display seconds
DIV b1

MOV Sdigit1, AL
MOV Sdigit2, AH



;;;;;;;;;;;;;;;;;;;;;;;;;does calculations for minutes 
MOV AL, m;
XOR AH, AH; AX copies m

MOV b1, 60
DIV b1       ; checking for 60 minutes

ADD h, AL  ;this increments hours if minutes/60 is quotient of 1

MOV m, AH  ;uses remainder to display minutes

MOV AL, m;
XOR AH, AH; 

MOV b1, 10 ;splits remainder into 2 digits to display minutes
DIV b1

MOV Mdigit1, AL
MOV Mdigit2, AH



;;;;;;;;;;;;;;;;;;;;;;;;;;does calculations for hours
MOV AL, h;
XOR AH, AH; AX copies s

MOV b1, 12
DIV b1       ; checking for 12 hours

MOV h, AH ;uses remainder to display hours

MOV AL, h;
XOR AH, AH; 

MOV b1, 10  ;splits remainder into 2 digits to display hours
DIV b1

MOV Hdigit1, AL
MOV Hdigit2, AH




;;;;;;;;;;;;;;;;;;;;print hours
MOV DL, Hdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Hdigit2
ADD DL, 30h
int 21h



MOV DL, ':'
mov AH, 02h
int 21h



;;;;;;;;;;;;;;;;;;;print minutes
MOV DL, Mdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Mdigit2
ADD DL, 30h
int 21h



MOV DL, ':'
mov AH, 02h
int 21h



;;;;;;;;;;;;;;;;;;;;print seconds
MOV DL, Sdigit1
ADD DL, 30h
mov AH, 02h
int 21h

MOV DL, Sdigit2
ADD DL, 30h
int 21h




;;;;;;;;;printing new line
mov DL, 10   
    int 21h
    mov DL, 13
    int 21h




INC counter;
MOV AX, counter

CMP AX, 43200 ;;; number of seconds in 12 hours
   JZ skip2;

JMP mainLoop


skip2:

MOV AX, 4C00h
INT 21H

MAIN ENDP

END