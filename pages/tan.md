# TAN

TAN function returns the mathematical tangent of an angle.

## COMMAND SYNTAX

    TAN(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a numeric type.

## NOTES

The function calculates the result at the highest precision available
on the host system; it truncates the result to the current PRECISION
after calculation.

## EXAMPLES

    Adjacent = 42
    Angle = 34
    CRT "Opposite length = " : TAN(Angle)*Adjacent
