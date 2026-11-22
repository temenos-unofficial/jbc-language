# FDIV

The FDIV function performs floating point division on two numeric
values. (Similarly, FMUL does the multiplication.)

## COMMAND SYNTAX

    FDIV(expression1, expression2)
    FMUL(expression1, expression2)

## SYNTAX ELEMENTS

Both expression1 and expression 2 must evaluate to non-null numeric
values.

## NOTES

If either of the arguments evaluates to null then a run time
"non-numeric" error will occur.

If the second argument evaluates to zero then a run time "divide by
zero" error will occur.

The calculation is not subject to the PRECISION setting.

## EXAMPLE

        CRT FDIV(1, 7)                   ;* 0.1428571429
        CRT FMUL(2.54, 5.703358)         ;* 14.48652932
