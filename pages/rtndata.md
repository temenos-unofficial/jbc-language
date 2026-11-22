# RTNDATA

RTNDATA statement allows a jBC program to return specific data to the
RTNDATA clause of another program's [EXECUTE](https://jbc-lang.org/pages/execute.md) statement.

## COMMAND SYNTAX

    RTNDATA expression

## SYNTAX ELEMENTS

**expression** may evaluate to any data type.

## NOTES

When a jBC program executes another jBC program using the EXECUTE
statement it may specify a variable to pick up data in using the
RTNDATA clause. The data picked up will be that specified by the
executed program using the RTNDATA statement.

The data will be discarded if the program is not executed by an
[EXECUTE](https://jbc-lang.org/pages/execute.md) statement in another program.
