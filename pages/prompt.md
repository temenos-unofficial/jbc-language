# PROMPT

PROMPT statement is used to change the PROMPT character used by terminal
input commands.

## COMMAND SYNTAX

    PROMPT expression

## SYNTAX ELEMENTS

**expression** can evaluate to any printable string.

## NOTES

The entire string is used as the prompt.

The default prompt character is the question mark "?" character.

## EXAMPLE

    PROMPT "Next answer : "
    INPUT Answer
