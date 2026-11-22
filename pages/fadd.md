# FADD

The FADD function performs floating point addition of two numeric
values.

## COMMAND SYNTAX

    FADD(expression1, expression2)

## SYNTAX ELEMENTS

Both expression1 and expression 2 must evaluate to non-null numeric
values.

## NOTES

If either of the arguments evaluates to null then a run time
"non-numeric" error will occur.

## EXAMPLES

    PRECISION 7
    CRT FADD(0.5044, 23.7290002)

displays 24.2334002
