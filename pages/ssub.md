# SSUB

SSUB function performs string subtraction of two base 10-string numbers.

## COMMAND SYNTAX

    SSUB(expr1, expr2)

## SYNTAX ELEMENTS

**expr1** and **expr2** are strings consisting of numeric characters,
optionally including a decimal part.

## NOTES

Use the SSUB function with numbers that may exceed a valid range with
standard arithmetic operators.
The [PRECISION])(#PRECISION) declaration has no effect on the value
returned by SSUB.

## EXAMPLES

    A = 2.3000000123456789
    B = 5.0000000000000001
    CRT SSUB(A,B)

Displays -2.69999998765432 to the screen.
