# ISPRINT

The ISPRINT function will check that the expression consists of entirely
printable characters.

## COMMAND SYNTAX

    ISPRINT(expression)

## SYNTAX ELEMENTS

The expression can return a result of any type. The ISPRINT function will
then return TRUE (1) if the expression consists of entirely printable
characters. The function will return FALSE (0) if the expression contains
any characters, which are not printable.

## INTERNATIONAL MODE

When the ISPRINT function is used in International Mode the properties of
each character is determined according to the Unicode Standard.

***TAFJ note: an example that works incorrectly:***

       a_string = 'cawerc' :@FM
       IF ISPRINT(a_string) THEN CRT 'ISPRINT()'
       ELSE CRT 'NOT ISPRINT()'

Expected result: NOT ISPRINT().

Result: ISPRINT().
