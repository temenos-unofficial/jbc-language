# PWR

PWR function raises a number to the n'th power.

## COMMAND SYNTAX

    PWR(expression1, expression2)

or

    expression1 ^ expression2

## SYNTAX ELEMENTS

Both **expression1** and **expression2** should evaluate to numeric
arguments. The function will return the value of expression1 raised
to the value of expression2.

## NOTE

If expression1 is negative and expression2 is not an integer then a
maths library error is displayed and the function returns the value
0. The resulting output is "0.0nan".

All calculations are performed at the maximum precision supported on
the host machine and truncated to the compiled precision on completion.

## EXAMPLE

          A = 2
          B = 31
          CRT "2 GB is " : A ^ B                   ;* 2 GB is 2147483648
          CRT "2 GB is definitely " : PWR(A, B)    ;* 2 GB is definitely 2147483648
          CRT "-2 GB is " : NEG(A)^B               ;* -2 GB is -2147483648
          CRT "2 to the power of 31.5 is " : PWR(A, B+0.5)
                                       ;* 2 to the power of 31.5 is 3037000499.9761
          CRT "-2 to the power of 31.5 is " : PWR( NEG(A), B+0.5)
                                       ;* -2 to the power of 31.5 is 0.0nan
