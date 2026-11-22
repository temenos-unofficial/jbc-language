# SUBROUTINE

SUBROUTINE statement is used at the start of any program that will be
called externally by the [CALL](https://jbc-lang.org/pages/call.md) statement. It also declares any
parameters to the compiler.

## COMMAND SYNTAX

    SUB{ROUTINE} Name {({ MAT } variable{,{ MAT } variable...})}

## SYNTAX ELEMENTS

**Name** is the identifier by which the subroutine will be known to the
compilation process. It should always be present as this name (not the
source file name), will be used to call it by. However, if the name is
left out, the compiler will name subroutine as the source file name
(without suffixes). Default naming is not encouraged as it can cause
problems if source files are renamed.

Each comma separated variable in the optional parenthesized list is used
to identify parameters to the compiler. These variables will be assigned
the values passed to the subroutine by a CALL statement.

## NOTES

The SUBROUTINE statement must be the first code line in a subroutine.

All the variables declared using the [COMMON](https://jbc-lang.org/pages/common.md)
statement will be inherited providing an equivalent common
area is declared within the subroutine source file.
The program will fail to compile if the number of common variables
used in each common area exceeds the number defined in the equivalent
area in the main program.

Subroutines can only be called via the jBC [CALL](https://jbc-lang.org/pages/call.md) statement.

[PRECISION](https://jbc-lang.org/pages/precision.md) can be redefined but the new setting
will not persist when the subroutine returns to the calling program.

The control will be returned to the CALLing program if the subroutine reaches the
logical end of the program or a [RETURN](https://jbc-lang.org/pages/return.md) is executed with
no outstanding [GOSUB](https://jbc-lang.org/pages/gosub.md) statement.

The control will not be returned to the calling program
if a [STOP](https://jbc-lang.org/pages/stop.md) or [ABORT](https://jbc-lang.org/pages/abort.md) statement is executed.

See also: [CALL](https://jbc-lang.org/pages/call.md), [CATALOG Command](https://jbc-lang.org/pages/catalog_command.md), [COMMON](https://jbc-lang.org/pages/common.md),
[RETURN](https://jbc-lang.org/pages/return.md).

## EXAMPLES

    SUBROUTINE DialUp(Number, MAT Results)
    DIM Results(8)
    ....
