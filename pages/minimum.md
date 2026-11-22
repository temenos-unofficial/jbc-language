# MINIMUM

MINIMUM function is used to return the element of a dynamic array
with the lowest numerical value.

## COMMAND SYNTAX

    MINIMUM(DynArr)

## SYNTAX ELEMENTS

**DynArr** should evaluate to a dynamic array.

## NOTES

Null dynamic array elements are treat as zero.

Non-numeric dynamic array elements are ignored.

See also: [MAXIMUM](https://jbc-lang.org/pages/maximum.md).

## EXAMPLES

If EResults is a variable containing the dynamic array:

    1.45032:@AM:-3.60851:@VM:4.29445:@AM:2.07042:@SM:-3.90258

the code:

    PRECISION 3
    CRT MINIMUM(EResults)

displays -3.903
