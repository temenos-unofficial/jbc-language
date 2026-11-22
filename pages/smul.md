# SMUL

SMUL function performs string multiplication of two base 10-string
numbers.

## COMMAND SYNTAX

    SMUL(expr1, expr2)

## SYNTAX ELEMENTS

**expr1** and **expr2** are strings consisting of numeric characters,
with either optionally including a decimal part.

## NOTES

Use the SMUL function with numbers that may exceed a valid range with
standard arithmetic operators.

The PRECISION declaration does not affect the value returned by SMUL.

## EXAMPLES

    A = 243603310027840922
    B = 3760
    CRT SMUL(A,B)

Displays 915948445704681866720 to the screen

    CRT SMUL(0.0000000000000475,3.61)

Displays 0.0000000000001714 to the screen
