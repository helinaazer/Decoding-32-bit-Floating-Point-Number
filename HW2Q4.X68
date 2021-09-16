*-----------------------------------------------------------
* Title      : Homework 2 Question 4
* Written by : Helina Azer
* Date       : 4/19/2021
* Description: Decode a 32-bit floating point number into sign bit, exponent, and mantissa bits
*-----------------------------------------------------------
CR  EQU    $0D
LF  EQU    $0A

INPUT                       DS.B 0
PROMPT                      DC.B 'Enter number in decimal: ' , 0 
SIGNBITRESULT               DC.B 'Sign bit: ' , 0
EXPONENTRESULT              DC.B 'Exponent: ' , 0
MANTISSARESULT              DC.B 'Mantissa: ' , 0
NEGATIVESIGN                DC.B 'Sign bit: -' , CR, LF, 0
POSITIVESIGN                DC.B 'Sign bit: +' , CR, LF, 0
BREAK                       DC.B ' ' , CR, LF, 0    

    ORG    $4000
    
START:                                                                ; first instruction of program

    CLR                     D0
    LEA                     PROMPT, A1                                ; Load input message
    MOVE.B                  #14, D0
    TRAP                    #15
    MOVE.B                  #4,D0
    TRAP                    #15
    MOVE.L                  D1, INPUT                                 ; move the user input into D1
    
FINDSIGNBIT:
 
    MOVE.L                  D1, D3
    BMI                     NEGATIVE
    LEA                     POSITIVESIGN, A1
    MOVE.B                  #14, D0
    TRAP                    #15
    BRA                     FINDEXPONENT
    
NEGATIVE:

    LEA                     NEGATIVESIGN, A1
    MOVE.B                  #14, D0
    TRAP #15
    
FINDEXPONENT:

    MOVE.L                  D1, D4
    ROL.L                   #$08, D4                                  ; Move left by 9 bits to get Exponenent
    ROL.L                   #$01, D4
    LEA                     EXPONENTRESULT, A1
    MOVE.B                  #14, D0         
    TRAP                    #15                                       ; Trap 15
    CLR.L                   D1                                        ; Clear D1
    MOVE.B                  D4, D1
    MOVE.B                  #3,D0
    TRAP                    #15                                       ; Trap 15
    LEA BREAK,              A1
    MOVE.B                  #14, D0
    TRAP                    #15                                       ; Trap 15
    CLR.L                   D1                                        ; Clear D1
    
FINDMANTISSA:

    MOVE.L                  INPUT, D5
    LSL.L                   #8, D5
    LSL.L                   #1, D5                                    ; Shift left for mantissa
    LSR.L                   #8, D5
    LSR.L                   #1, D5                                    ; Shift right when there are leading 0s
    LEA                     MANTISSARESULT, A1
    MOVE.B                  #14, D0
    TRAP                    #15                                       ; Trap 15
    CLR.L                   D1                                        ; Clear D1
    MOVE.L                  D5, D1                                    ; Move D5 into D1
    MOVE.B                  #3, D0                                    ; Move decimal into D0
    TRAP                    #15                                       ; Trap 15
    
    SIMHALT             ; halt simulator

    END    START       ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
