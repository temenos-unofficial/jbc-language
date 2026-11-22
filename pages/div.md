# DIV

Use the DIV function to calculate the value of the quotient after
division of the dividend by the divisor.

## COMMAND SYNTAX

    DIV(dividend, divisor)

The dividend and divisor expressions can evaluate to any numeric
value. The only exception is that the divisor cannot be zero. If
either dividend or divisor evaluates to null, it returns null.
DIV is PRECISION-dependent.

## EXAMPLE

       CRT DIV(400, 200)                     ;* 2
       CRT DIV(200, 400)                     ;* 0.5
       CRT DIV(200, -400)                    ;* -0.5
       PRECISION 9
       CRT DIV(1, 10000000000)               ;* 0
       PRECISION 17
       CRT DIV(1, 10000000000)               ;* 0.0000000001
