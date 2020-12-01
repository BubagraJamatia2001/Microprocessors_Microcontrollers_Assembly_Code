.DATA
    N1 DB ?
    N2 DB ?
    R1 DB ? 

.CODE
    MOV CX, 8 ;NUMBER OF TIMES TO RUN 
    SUB CX, 1 ;BECAUSE WE'RE GOING TO PRINT THE FIRST NUMBER OF THE SEQUENCE OUTSIDE THE LOOP SO WE DECREMENT
              ;THE COUNTER BY 1
    
    MOV N1, 0 ;FIRST NUMBER 
    MOV N2, 1 ;SECOND NUMBER
    
    MOV DL, N1 ;MOVES FIRST NUMBER TO DL
    ADD DL, 30H ;WE DO THIS TO GET THE ASCII VALUE OF '0' TO PRINT IT
    MOV AH, 02H ;PRINTS TO SCREEN AFTER INT 21H
    INT 21H
    
    MOV DL, N2
    ADD DL, 30H ;WE DO THIS TO GET THE ASCII VALUE OF '1' TO PRINT IT
    INT 21H ;WE DON'T DO MOV AH, 02H HERE BECAUSE THIS VALUE IS ALREADY THERE IN AH
    
    LOOP1:
        MOV DL, ' '
        INT 21H ;DO THIS TO PRINT A SPACE BETWEEN THE NUMBERS IN THE SEQUENCE
        MOV AL, N1
        ADD AL, N2 ;ADD TO GET THE NEXT NUMBER IN THE SEQUENCE
        MOV AH, 0 ;WE DO THIS TO MAKE SURE THAT THE DIVISION LATER PUTS CORRECT DIGITS IN AH AND AL
        MOV BL, AL ;WE STORE THIS VALUE FOR LATER USE, WILL SEE IN THE 'REPLACE' LABEL
        MOV DL, 10
        DIV DL ;WE DIVIDE BY 10(A) SO THAT THE FIRST NUMBER TO BE SHOWN IS IN AL, AND THE 2ND IS IN AH
        ADD AX, 3030H ;WE ADD 3030H SO THAT THE NUMBERS REPRESENT INTEGER DIGITS BY ASCII VALUE 
        
        MOV R1, AH
        MOV DL, AL
        MOV AH, 02H
        INT 21H ;PRINT FIRST DIGIT     
        
        MOV DL, R1
        INT 21H ;PRINT SECOND DIGIT
        
    REPLACE: ;HERE WE MAKE N1 AND N2 GET THE LATEST VALUES IN THE FIBONACCI SEQUENCE
        MOV AL, N2
        MOV N1, AL
        MOV N2, BL
        LOOP LOOP1