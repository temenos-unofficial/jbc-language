# LENDP

LENDP function returns the display length of an expression

## COMMAND SYNTAX

    LENDP(expression)

## SYNTAX ELEMENTS

The **expression** can evaluate to any type. The LENDP function
evaluates each character in the expression and returns the calculated
display length.

INTERNATIONAL MODE

The LENDP function will return the display length for the characters
in the specified expression rather than the number of bytes, in
International Mode.

## NOTES

Some characters, usually Japanese, Chinese, etc will return a display
length of greater than one for some characters. Some characters, for
instance control characters or null (char 0), will return a display
length of 0.
