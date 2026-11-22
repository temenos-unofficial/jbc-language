# SIN

SIN function returns the mathematical sine value of a numeric
expression.

## COMMAND SYNTAX

    SIN(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a numeric value and is interpreted
as a number of degrees between 0 and 360.

## NOTES

The function will calculate the sine of the angle specified by the
expression as accurately as the host system will allow. It will then
truncate the value according to the PRECISION of the program.

## EXAMPLE

    CRT @(-1):
    FOR I = 0 TO 79
       CRT @(I,12 + INT( SIN(360/80*(I+1))*10)) : "*" :
    NEXT I
