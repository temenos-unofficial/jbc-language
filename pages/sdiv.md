# SDIV

SDIV function performs a string division of two base 10-string numbers
and rounds the result to 14 decimal places.

## COMMAND SYNTAX

    SDIV(expr1, expr2)

## SYNTAX ELEMENTS

**expr1** and **expr2** are strings consisting of numeric characters,
with either optionally including a decimal part.

## NOTES

Use the SDIV function with numbers that may exceed a valid range with
standard arithmetic operators.

The [PRECISION](https://jbc-lang.org/pages/precision.md) declaration has no effect on the value
returned by SDIV.

## EXAMPLE

    A = 2
    B = 3
    CRT SDIV(A,B)

Displays 0.66666666666666 to the screen

    CRT SDIV(355,113)

Displays 3.14159292035398 to the screen
