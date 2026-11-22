# EBCDIC

The EBCDIC function converts all the characters in an expression
from the ASCII character set to the EBCDIC character set.

## COMMAND SYNTAX

    EBCDIC(expression)

## SYNTAX ELEMENTS

**expression** may contain a data string of any form. The function
will convert it to a character string, assume that the characters
are all members of the ASCII set and translate them using a character
map. The original expression is unchanged while the returned result
of the function is now the EBCDIC equivalent.

## EXAMPLE

    READT AsciiBlock ELSE CRT "Tape failed!" ; STOP
    EbcdicBlock = EBCDIC(AsciiBlock) ;* Convert to EBCDIC
