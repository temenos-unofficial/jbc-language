# COS

The COS function calculates the cosine of any angle using floating
point arithmetic, then rounds to the precision implied by the jBC
program, which makes it very accurate.

## COMMAND SYNTAX

    COS(expression)

This function calculates the cosine of an expression.

## SYNTAX ELEMENTS

The expression must evaluate to a numeric result or a runtime error
will occur.

## NOTES

Assumes the value returned by expression is in degrees.

## EXAMPLES

       * print cos i for 1 to 360 degrees
       FOR I = 1 TO 360
          cos_i = COS(I)
          CRT cos_i
          IF ABS(cos_i) GT 1 THEN CRT "It's wartime"
       NEXT I
