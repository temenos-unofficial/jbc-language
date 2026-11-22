# CALL

The CALL statement transfers program execution to an external
subroutine.

## COMMAND SYNTAX

    CALL {@} subroutine.name {(argument{, argument ... })}

## SYNTAX ELEMENTS

The CALL statement transfers program execution to the subroutine
called subroutine.name, which can be any valid string either quoted
or unquoted.

The CALL @ variant of this statement assumes that subroutine.name
is a variable that contains the name of the subroutine to call.

The CALL statement may optionally pass a number of parameters to the
target subroutine. These parameters can consist of any valid
expression or variable name. If a variable name is used then the
called program may return a value to the variable by changing the
value of the equivalent variable in its own parameter list.

## NOTES

When using an expression to pass a parameter to the subroutine, you
cannot use the built-in functions of jBC (such as COUNT), within the
expression.

An unlimited number of parameters can be passed to an external
subroutine. The number of parameters in the CALL statement must match
exactly the number expected in the SUBROUTINE statement declaring the
external subroutine, otherwise runtime error is raised.

It is not required that the calling program and the external
subroutine be compiled with the same PRECISION. However, any changes
to precision in a subroutine will not persist when control returns
to the calling program.

Variables passed as parameters to the subroutine may not reside in
any COMMON areas declared in the program.

## EXAMPLE

A subroutine:

       SUBROUTINE NUM.INCR(P.NUMBER)
    * increase the parameter
       P.NUMBER ++
       RETURN
    END

A calling program:

       V.ARRAY = 1 :@FM: 2 :@FM: 3 :@FM: 4
       CRT FMT(V.ARRAY, 'MCP')   ;* 1^2^3^4
       V.ARRAY<2> += 1
       CRT FMT(V.ARRAY, 'MCP')  ;* 1^3^3^4 - array element can be processed directly
       CALL NUM.INCR(V.ARRAY<2>)
       CRT FMT(V.ARRAY, 'MCP')   ;* still 1^3^3^4 - passing to a subr doesn't work
       V.VAR = V.ARRAY<2>
       CALL NUM.INCR(V.VAR)
       V.ARRAY<2> = V.VAR
       CRT FMT(V.ARRAY, 'MCP')   ;* now 1^4^3^4 - should use a variable
       V.SUBR = 'NUM.INCR'
       CALL @V.SUBR(V.VAR)       ;* can call a subroutine this way
       CRT V.VAR                 ;* 5
    * Dimensioned array is ok as well
       DIM V.DIM.ARR(3)
       V.DIM.ARR(2) = 'NUM.INCR'
       V.I = 2
       CALL @V.DIM.ARR(V.I) (V.VAR)
       CRT V.VAR        ;* 6
    * Pass by value rather than by reference - variable keeps its value:
       CALL NUM.INCR((V.VAR))
       CRT V.VAR        ;* 6
    * Wrong CALL:
       CALL NUM.INCR(V.VAR, 1)

Output:

<pre>
    1^2^3^4
    1^3^3^4
    1^3^3^4
    1^4^3^4
    5
    6
    6
     &lowast;&lowast; Error [ SUBROUTINE_PARM_ERROR ] &lowast;&lowast;
    'SUBROUTINE NUM.INCR' called with incorrect arguments , Line 1 , Source test2.b
    Trap from an error message, error message name = SUBROUTINE_PARM_ERROR
    Source changed to .\test2.b
    jBASE debugger-></pre>
