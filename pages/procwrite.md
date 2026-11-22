# PROCWRITE

PROCWRITE statement is used to pass data back to the primary input
buffer of a calling jCL program.

## COMMAND SYNTAX

    PROCWRITE expression

## SYNTAX ELEMENTS

**expression** may evaluate to any valid data type.

## NOTES

See also: [PROCREAD](https://jbc-lang.org/pages/procread.md)

## EXAMPLE

    PROCWRITE "Success" : CHAR(254) : "0"
