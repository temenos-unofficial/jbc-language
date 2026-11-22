# WAKE

WAKE statement is used to wake a suspended process, which has
executed a [PAUSE](https://jbc-lang.org/pages/pause.md) statement.

## COMMAND SYNTAX

    WAKE PortNumber

## SYNTAX ELEMENTS

**PortNumber** is a reference to awaken the target port. The WAKE
statement has no effect on processes, which do not execute the PAUSE
statement.
