# ISDIGIT

The ISDIGIT function will check that the expression consists of entirely
numeric characters.

## COMMAND SYNTAX

    ISDIGIT(expression)

## SYNTAX ELEMENTS

The expression can return a result of any type. The ISDIGIT function
will then return TRUE (1) if the expression consists of entirely
numeric characters. The function will return FALSE (0) if the
expression contains any characters, which are not numeric.

## INTERNATIONAL MODE

When the ISDIGIT function is used in International Mode the properties
of each character is determined according to the Unicode Standard.

## EXAMPLE

       V.VAR = 5
       CRT ISDIGIT(V.VAR)                 ;* 1
       V.VAR = -1
       CRT ISDIGIT(V.VAR)                 ;* 0 (we have minus now)
