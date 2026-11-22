# SADD

SADD function performs string addition of two base 10-string numbers.

## COMMAND SYNTAX

    SADD(expr1, expr2)

## SYNTAX ELEMENTS

**expr1** and **expr2** are strings consisting of numeric characters,
optionally including a decimal part.

## NOTES

The SADD function can be used with numbers that may exceed a valid
range with standard arithmetic operators.
The [PRECISION](https://jbc-lang.org/pages/precision.md) declaration has no effect on the value
returned by SADD.

## EXAMPLE

    A = 4000000000000000000000000000000
    B = 7
    CRT SADD(A,B)

Displays 4000000000000000000000000000007 to the screen

    CRT SADD(4.33333333333333333,1.8)

Displays 6.13333333333333333 to the screen

***TAFJ note: parameters are to be in quotes:***

       CRT SADD('4000000000000000000000000000000', '7')  ;* 4000000000000000000000000000007
       CRT SADD(4000000000000000000000000000000, 7)      ;* 9223372036854775814
