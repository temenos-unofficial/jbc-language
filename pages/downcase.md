# DOWNCASE

DOWNCASE converts all uppercase characters in an expression to lowercase
characters.

UPCASE converts all lowercase characters in an expression to uppercase
characters.

## COMMAND SYNTAX

    DOWNCASE(expression) | LOWCASE(expression) / UPCASE(expression)

## INTERNATIONAL MODE

When using the DOWNCASE or UPCASE function in International Mode the
conversion from upper case to lower case or vice versa will be
determined for each character in the expression by the Unicode
standard, which describes the up or down case properties for the
character.

## SYNTAX ELEMENTS

**expression** in a string containing some alphabetic characters

## NOTES

It ignores Non-alphabetic characters.
