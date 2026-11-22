# INT

The INT function truncates a numeric value into its nearest integer
form.

## COMMAND SYNTAX

    INT(expression)

## SYNTAX ELEMENTS

expression should evaluate to a numeric value. The function will then
return the integer portion of the value.

## NOTES

The function works by truncating the fractional part of the numeric
value rather than by standard mathematical rounding techniques.
Therefore, INT(9.001) and INT(9.999) will both return the value 9.

## EXAMPLES

    CRT INT(22 / 7)

Displays the value 3
