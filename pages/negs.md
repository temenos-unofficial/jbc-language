# NEGS

NEGS function returns the negative values for all the elements in a
dynamic array. NEG() function returns the negative value for a variable
or an expression.

## COMMAND SYNTAX

    NEGS(dynamic.array)

If the value of an element is negative, the returned value is positive.
If dynamic.array evaluates to null, null is returned. If any element
is null, null is returned for that element.

## EXAMPLE

       dyn_array = 1 :@FM: 2 :@VM :3
       GOSUB PROC.IT                              ;* -1^-2]-3
       dyn_array = 1 :@FM: '' :@VM :3
       GOSUB PROC.IT                              ;* -1^0]-3
       dyn_array = -1 :@FM: -2 :@VM: -3
       GOSUB PROC.IT                              ;*  1^2]3
       dyn_array = 1 :@SM: -2 :@FM: 3
       GOSUB PROC.IT                              ;*  -1\2^-3
       dyn_array<-1> = 'A text'
       GOSUB PROC.IT                            ;* Non-numeric value -- ZERO USED
                                                ;* -1\2^-3^0
       CRT NEG(0)                               ;* 0
       CRT NEG(100)                             ;* -100
       CRT NEG(dyn_array<1> LT dyn_array<2>)    ;* -1 (negative of "true")
       CRT NEG(-1000)                           ;* 1000
       CRT NEG('qwert')                         ;* Non-numeric value -- ZERO USED
                                                ;* 0
       STOP
       &nbsp;
    PROC.IT:
       CRT FMT( NEGS(dyn_array), 'MCP' )
       RETURN
    END
