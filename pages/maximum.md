# MAXIMUM

MAXIMUM function is used to return the element of a dynamic array with
the highest numerical value.

## COMMAND SYNTAX

    MAXIMUM(DynArr)

## SYNTAX ELEMENTS

**DynArr** should evaluate to a dynamic array.

## NOTES

Null dynamic array elements are treat as zero.

Non-numeric dynamic array elements are ignored.

See also: [MINIMUM](https://jbc-lang.org/pages/minimum.md)

## EXAMPLES

       PRECISION 5
       dyn_array = 4.29442 :@AM: -3.60441 :@VM :4.29445 :@AM: 2.00042   \
             :@SM: -33.90228
       CRT MAXIMUM(dyn_array)           ;* 4.29445
    * non-numeric elements are ignored
       dyn_array<2,1> = '9000,00'
       CRT MAXIMUM(dyn_array)           ;* still 4.29445
    * PRECISION matters
       PRECISION 2
       CRT MAXIMUM(dyn_array)           ;* now 4.29442
