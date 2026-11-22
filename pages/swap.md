# SWAP

SWAP function operates on a variable and replaces all occurrences of
one string with another

## COMMAND SYNTAX

    SWAP(variable, expression1, expression2)

## SYNTAX ELEMENTS

**expression1** may evaluate to any result and is the string of
characters that will be replaced.

**expression2** may also evaluate to any result and is the string of
characters that will replace expression1. The variable may be any
previously assigned variable in the program.

## NOTES

Either string can be of any length and is not required to be the same
length. This function is provided for compatibility with older
systems.

See also: [CHANGE](https://jbc-lang.org/pages/change.md) function.

## EXAMPLE

    String1 = "Jim"
    String2 = "James"
    Variable = "Pick up the tab Jim"
    CRT SWAP(Variable, String1, String2)
    CRT SWAP(Variable, 'tab', 'check')
