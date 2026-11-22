# MOD

MOD function returns the arithmetic modulo of two numeric expressions.

## COMMAND SYNTAX

    MOD(expression1, expression2)

## SYNTAX ELEMENTS

Both **expression1** and **expression2** should evaluate to numeric
expressions or else runtime error will occur.

## NOTES

The remainder of expression1 divided by expression2 calculates the
modulo. If expression2 evaluates to 0, then the value of
expression1 is returned.

## EXAMPLES

    FOR I = 1 TO 10000
       IF MOD(I, 1000) = 0 THEN CRT "+" :
    NEXT I

displays a "+" on the screen every 1000 iterations.
