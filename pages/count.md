# COUNT

The COUNT function returns the number of times that one string occurs
in another.

## COMMAND SYNTAX

    COUNT(expression1, expression2)

## SYNTAX ELEMENTS

Both expression1 and expression2 may evaluate to any data type but
logically they will evaluate to character strings.

## NOTES

Quote from older documentation: "The count is made on overlapping occurrences as a pattern match from
each character in expression1. This means that the string jjj occurs
3 times in the string jjjjj".

This is no more the case (TAFC R19), see example 2 below.

See also: [DCOUNT](https://jbc-lang.org/pages/dcount.md)

## EXAMPLES

    Calc = "56 * 23 / 45 * 12"
    CRT "There are " : COUNT(Calc, '*') : " multiplications"

    CRT COUNT('jjjjj', 'jjj')     ;* 1
