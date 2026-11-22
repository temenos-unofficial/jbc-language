# SQRT

SQRT function returns the mathematical square root of a value.

## COMMAND SYNTAX

    SQRT(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a positive numeric value as
the authors do not want to introduce a complex number type
within the language. Negative values will cause a math error.

## NOTE

The function calculates the result at the highest precision
available and then truncates the answer to the required
PRECISION.

***TAFJ R23 note: incorrect rounding of results.***

## EXAMPLE

    PRECISION 6
    *
    FOR i = 1 TO 10
        CRT SQRT(i) : ' | ' :
    NEXT i

    * TAFC: 1 | 1.414214 | 1.732051 | 2 | 2.236068 | 2.44949 | 2.645751 | 2.828427 | 3 | 3.162278 |
    * TAFJ: 1 | 1 | 2 | 2 | 2.2 | 2.4 | 2.6 | 2.8 | 3 | 3.2 |
