# BYTELEN

The BYTELEN function will return the length of the expression as the
number of bytes rather than the number of characters.

## COMMAND SYNTAX

    BYTELEN(expression)

## SYNTAX ELEMENTS

The expression is to be a string. The BYTELEN function
will then return the byte count of the expression.

## EXAMPLE

       V.UTF = 'ABCDEF' \
             : CHAR(353) : CHAR(352) : CHAR(269) : CHAR(268) : CHAR(263) \
             : CHAR(262) : CHAR(382) : CHAR(381) : CHAR(273) : CHAR(272)
       V.LEN = LEN(V.UTF)  ;  CRT V.LEN  ;* 16
       CRT BYTELEN(V.UTF)                ;* 26
    *
    * [] takes characters, not bytes, so output is:
    * 41 42 43 44 45 46 C5A1 C5A0 C48D C48C C487 C486 C5BE C5BD C491 C490
       FOR V.I = 1 TO V.LEN
          CRT FMT(V.UTF[V.I,1], 'MX') : ' ' :
       NEXT V.I

## NOTES

The BYTELEN function will always return the actual byte count for the
expression; irrespective of the International Mode in operation at
the time. This compares with the LEN function, which will return a
character count. The character count may differ from the byte count
when processing in International Mode.
