# ISCNTRL

The ISCNTRL function will check that the expression consists entirely of
control characters.

## COMMAND SYNTAX

    ISCNTRL(expression)

## SYNTAX ELEMENTS

The expression can return a result of any type. The ISCNTRL function will
then return TRUE (1) if the expression consists of entirely control
characters. The function will return FALSE (0) if the expression contains
any characters, which are not control characters.

## INTERNATIONAL MODE

When the ISCNTRL function is used in International Mode the properties
of each character is determined according to the Unicode Standard.

## EXAMPLE

       V.STRING = CHAR(13) : CHAR(10)
       CRT ISCNTRL(V.STRING)        ;* 1
       V.STRING = @FM : V.STRING
       CRT ISCNTRL(V.STRING)        ;* 1

***TAFJ note: an example that works incorrectly:***

       a_string = CHAR(10) : 'AWERC+' : CHAR(10)
       IF ISCNTRL(a_string) THEN CRT 'ISCNTRL()'
       ELSE CRT 'NOT ISCNTRL()'

Expected result: NOT ISCNTRL().

Result: ISCNTRL().
