# FSUB

The FSUB function performs floating-point subtraction on two numeric
values.

## COMMAND SYNTAX

    FSUB(expression1, expression2)

## SYNTAX ELEMENTS

Both expression1 and expression 2 must evaluate to non-null numeric
values.

## NOTES

If either of the arguments evaluates to null then a run time "non-numeric"
error will occur.

## EXAMPLES

    PRECISION 7
    CRT FSUB(2.54, 5.703358)

displays -3.163358
