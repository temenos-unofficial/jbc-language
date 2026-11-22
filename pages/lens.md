# LENS

LENS function is used to return a dynamic array of the number of bytes
in each element of the dynamic.array.

## COMMAND SYNTAX

    LENS(dynamic.array)

Each element of dynamic.array must be a string value. The characters
in each element of dynamic.array are counted, with the counts returned.

The LENS function includes all blank spaces, including trailing blanks,
in the calculation.

If dynamic.array evaluates to a null string, it returns zero (0). If
any element of dynamic.array is null, returns zero (0) for that element.

## INTERNATIONAL MODE

The LENS function will return the number of characters in the specified
expression rather than the number of bytes, in International Mode. If
the expression consists of entirely of UTF-8 characters in the ASCII
range 0 - 127 then the character length of the expression will equate
to the byte length. However, when the expression contains characters
outside the ASCII range 0 - 127 then byte length and character length
will differ. See
[BYTELEN](https://jbc-lang.org/pages/bytelen.md) function for more information.

## NOTES

Do not use programs to manipulate byte counts in International Mode.
