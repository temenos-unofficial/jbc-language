# ISALNUM

The ISALNUM function will check that the expression consists of
entirely alphanumeric characters.

## COMMAND SYNTAX

    ISALNUM(expression)

## SYNTAX ELEMENTS

The expression can return a result of any type. The ISALNUM function
will then return TRUE (1) if the expression consists of entirely
alphanumeric characters. The function will return FALSE (0) if the
expression contains any characters, which are not alphanumeric.

## INTERNATIONAL MODE

When the ISALNUM function is used in International Mode the properties
of each character is determined according to the Unicode Standard.

## EXAMPLE

Extending the example for [ALPHA](https://jbc-lang.org/pages/alpha.md):

       V.STRING = 'AWERC'
    * check if there are only alphabetic characters
       CRT ISALPHA(V.STRING)             ;* 1
    * add number to the end
       V.STRING := 1   ; CRT V.STRING    ;* AWERC1
    * check again if there are only alphabetic characters
       CRT ISALPHA(V.STRING)             ;* 0
    * check if there are only alphanumeric characters
       CRT ISALNUM(V.STRING)             ;* 1
