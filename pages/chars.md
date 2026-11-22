# CHARS

The CHARS function accepts a dynamic array of numeric expressions and
returns a dynamic array of the corresponding ASCII characters.

## COMMAND SYNTAX

    CHARS(DynArr)

## SYNTAX ELEMENTS

Each element of DynArr must evaluate to a numeric argument in the range
0-255 (can exceed 255 if UTF-8 is used).

## NOTES

If any of the dynamic array elements are non-numeric, a run-time error
will occur.

See also: [CHAR](https://jbc-lang.org/pages/char.md)

## EXAMPLE

       V.ARRAY = 59 :@FM: 45 :@FM: 41
       V.CHARS = CHARS(V.ARRAY)
       CRT CHANGE(V.CHARS, @FM, '')

This code displays: ;-)
