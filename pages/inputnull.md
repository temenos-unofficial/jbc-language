# INPUTNULL

The INPUTNULL statement allows the definition of a character that
will allow a null input to be seen by the INPUT@ statement.

## COMMAND SYNTAX

    INPUTNULL expression

## SYNTAX ELEMENTS

The **expression** should evaluate to a single character.
Subsequently, any INPUT@ statement that sees only this character
input before the new-line sequence will NULL the variable in
which input is being stored.

If expression evaluates to the NULL string " then the default
character of _ is used to define a NULL input sequence.

## NOTES

The INPUT statement does not default to accepting the _ character
as a NULL input, the programmer must explicitly allow this with
the statement: INPUTNULL ''. In the example below an ampersand can be used
to input the empty value.

## EXAMPLE

    INPUTNULL "&"
    INPUT @(10,10):Answer,1
    IF Answer = '' THEN
       CRT "A NULL input was received"
    END
