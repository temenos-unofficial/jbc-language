# EXP

The EXP function returns the mathematical constant to the specified
power.

## COMMAND SYNTAX

    EXP(expression)

## SYNTAX ELEMENTS

The expression may consist of any form of jBC expression but should
evaluate to a numeric argument or a runtime error occurs and the
program enters the debugger.

## NOTES

The function returns a value that is accurate to as many decimal
places specified by the [PRECISION](https://jbc-lang.org/pages/precision.md) of the program.

## EXAMPLE

    zE10 = EXP(10) ;* Get e^10
