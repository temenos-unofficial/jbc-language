# SPACE

SPACE function generates a specific number of ASCII space characters.

## COMMAND SYNTAX

    SPACE(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a positive integer value.

## NOTES

The SPACE function is useful for padding strings. It should not be
used to position output on the terminal screen as this is
inefficient, accomplish this by using the [@](https://jbc-lang.org/pages/@.md).

## EXAMPLES

    TenSpaces = SPACE(10)
