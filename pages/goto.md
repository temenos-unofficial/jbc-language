# GOTO

The GOTO statement causes program execution to jump to the code at a
specified label.

## COMMAND SYNTAX

    GO{TO} Label

## SYNTAX ELEMENTS

The label should refer to an existing label within the current source
code.

## NOTES

Warning: using the GOTO command obscures the readability of the code
and is a hindrance to maintainability. All programs written using the
GOTO construct can be written using structured statements such as
LOOP and FOR. There are various opinions on this issue but the
consensus is, avoid GOTO.

One possibly acceptable use of the GOTO statement is to transfer
execution to an error handler upon detection of a fatal error that
will cause the program to terminate.

## EXAMPLE

    GOTO Exception ;* jump to the exception handler
    .....
    * exception handler
    Exception:
    ....
    STOP
