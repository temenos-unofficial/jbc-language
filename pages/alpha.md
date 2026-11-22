# ALPHA

The ALPHA function is used to check if the expression consists entirely of
alphabetic characters.

## COMMAND SYNTAX

    ALPHA(expression)

## SYNTAX ELEMENTS

Returns 1 if the expression consists entirely of alphabetic
characters, else returns 0.

## INTERNATIONAL MODE

When using the ALPHA function in International Mode it determines the
properties of each character in the expression according to the Unicode
Standard, which in turn describes whether the character is alphabetic
or not.

## EXAMPLE

       V.STRING = 'AWERC'
    * check if there are only alphabetic characters
       CRT ALPHA(V.STRING)        ;* 1
    * add number to the end
       V.STRING := 1   ; CRT V.STRING    ;* AWERC1
    * check again if there are only alphabetic characters
       CRT ALPHA(V.STRING)        ;* 0
