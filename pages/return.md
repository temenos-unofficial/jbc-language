# RETURN

RETURN statement transfers program execution to the caller of a
subroutine/function or to a specific label in the program.

## COMMAND SYNTAX

    RETURN {TO label}

or

    RETURN(expression)

## SYNTAX ELEMENTS

**label** must reference an existing label within the source of the
program.

**expression** evaluates to the value that is returned by a
user-written function.

## NOTES

The RETURN statement will transfer program execution to the statement
after the [GOSUB](https://jbc-lang.org/pages/gosub.md) that called the current internal subroutine.

If the [RETURN](https://jbc-lang.org/pages/return.md) statement is executed in an external SUBROUTINE
and there are no outstanding GOSUBs, then the program will transfer
execution back to the program that called it via CALL.

The program will enter the debugger with an appropriate message should a
RETURN be executed with no GOSUB or [CALL](https://jbc-lang.org/pages/call.md) outstanding.

The second form of the RETURN statement is used to return a value from a
user-written function. This form can only be used in a user-written
function.
