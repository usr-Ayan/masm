.MODEL SMALL                            ;DEFINES THE MEMORY MODEL TO BE USED FOR THE ALP
.DATA                                   ;DATA SEGMENT BEGINS HERE
        NAM DB 10D,13D,"Ayan Roy$"   ;STRING HELLO WORLD GETS STORED IN MSG
	PRO DB 10D,13D,"FIRST ASM PROGRAM$"
.CODE                                   ;CODE SEGMENT BEGINS HERE
        MOV AX,@DATA                    ;MOVING BASE ADDRESS OF DATA TO AX
        MOV DS,AX                       ;MOVING CONTENTS OF AX INTO DS
                                        ;DATA SECTION NOW GETS INITIALIZED
        LEA DX,NAM                      ;LOAD THE OFFSET ADDRESS OF MSG
        MOV AH,09H                      ;TO DISPLAY CONTENTS AT DX
        INT 21H                         ;CALL THE KERNEL
	
	LEA DX,PRO                     ;LOAD THE OFFSET ADDRESS OF MSG
        MOV AH,09H                      ;TO DISPLAY CONTENTS AT DX
        INT 21H 
        
        MOV AH,4CH                      ;TO TERMINATE THE PROGRAM
        INT 21H                         ;CALL THE KERNEL
END    
