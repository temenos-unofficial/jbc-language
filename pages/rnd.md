# RND

RND function allows the generation of random numbers by a program.

## COMMAND SYNTAX

    RND(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a numeric integer value or a runtime
error will occur. The absolute value of expression is used by the
function. The highest number expression can be on Windows is
PWR(2,15) - 1. The highest number on UNIX is PWR(2,31) - 1.

## NOTES

The function will return a random integer number between 0 and the value
of expression-1.

See also: [ABS](https://jbc-lang.org/pages/abs.md)

## EXAMPLE

    FOR I=1 TO 20
       CRT RND(100) : ", " :
    NEXT I

prints 20 random numbers in the inclusive range 0 to 99.
