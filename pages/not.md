# NOT

NOT function is used to invert the Boolean value of an expression.
It is useful for explicitly testing for a false condition.

## COMMAND SYNTAX

    NOT(expression)

## SYNTAX ELEMENTS

**expression** may evaluate to any Boolean result.

## NOTES

The NOT function will return Boolean TRUE if the expression returns
a Boolean FALSE. It will return Boolean FALSE if the expression
returns a Boolean TRUE.

The NOT function is useful for explicitly testing for the false
condition of some test and can clarify the logic of such a test.

## EXAMPLE

    EQU Sunday TO NOT( MOD( DATE(), 7))
    IF Sunday THEN
       CRT "It is Sunday!"
    END

In this example, the expression MOD (DATE(),7) will return 0 (FALSE)
if the day is Sunday and 1 to 6 (TRUE) for the other days. To
explicitly test for the day Sunday we need to invert the result of
the expression. By using the NOT function we return 1 (TRUE) if the
day is Sunday and 0 (FALSE) for all other values of the expression.
