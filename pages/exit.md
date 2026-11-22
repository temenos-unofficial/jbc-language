# EXIT

The EXIT statement halts the execution of a program and returns a
numeric exit code to the parent process. For compatibility with older
versions of the language, use the EXIT statement without an expression.
In this case, it is synonymous with the [BREAK](https://jbc-lang.org/pages/break.md) statement.

## COMMAND SYNTAX

    EXIT(expression)

    EXIT

## SYNTAX ELEMENTS

Any expression provided must be parenthesized and evaluate to a numeric
result. The numeric result is used as the UNIX or Windows exit code,
which is returned to the parent process by the C function exit(). If the
expression does not evaluate to a numeric result the program will enter
the debugger and display a suitable error message.

## NOTES

The expression has been forced to be parenthesized to avoid confusion
with the EXIT statement without an expression as much as is possible.
The authors apologize for having to provide two different meanings for
the same keyword

See also: [BREAK](https://jbc-lang.org/pages/break.md)

## EXAMPLE

    READ Record FROM FileDesc, RecordKey ELSE
        CRT "Record " : RecordKey : " is missing"
        EXIT(1)
    END ELSE
        CRT "All required records are present"
        EXIT(0)
    END

## EXAMPLE 2

       V.ARRAY = ''
       FOR V.I = 1 TO 10
          IF V.I EQ 4 THEN EXIT
          V.ARRAY<-1> = V.I
       NEXT V.I
       CRT FMT(V.ARRAY, 'MCP') ;* 1^2^3
