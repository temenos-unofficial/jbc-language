# WRITEVU

WRITEVU statement allows a program to write a specific field on a
record in a previously opened file. An existing record lock will
be preserved.

## COMMAND SYNTAX

    WRITEVU variable1 ON | TO {variable2,} expression1, expression2  \
          { SETTING setvar } { ON ERROR statements }

## SYNTAX ELEMENTS

**variable1** is the identifier holding the record to be written.

**variable2**, if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement. If
variable2 is not specified then the default file is assumed.

**expression1** should evaluate to a valid record key for the file.

**expression2** should evaluate to a positive integer number; if the
number is greater than the number of fields in the record, null fields
will be added to variable1. If expression2 evaluates to a non-numeric
argument, a run time error will be generated.

If the SETTING clause is specified and the write fails, it sets setvar
to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

If the statement fails to write the record, it executes any statements
associated with the ON ERROR clause.

Any of the following events will release the lock taken by the
[WRITEVU](https://jbc-lang.org/pages/writevu.md) statement:

The same program with [WRITE](https://jbc-lang.org/pages/write.md), [WRITEV](https://jbc-lang.org/pages/writev.md) or
[MATWRITE](https://jbc-lang.org/pages/matwrite.md) statements writes to the record.

By explicitly using the [RELEASE](https://jbc-lang.org/pages/release.md) statement, it
releases the record lock.

The program stops normally or abnormally.

See also: [MATWRITEU](https://jbc-lang.org/pages/matwriteu.md), [RELEASE](https://jbc-lang.org/pages/release.md),
[WRITE](https://jbc-lang.org/pages/write.md), [WRITEU](https://jbc-lang.org/pages/writeu.md).

## EXAMPLE

    OPEN "Customers" ELSE ABORT 201, "Customers"
    OPEN "DICT Customers" TO DCusts ELSE
       ABORT 201, "DICT Customers"
    END
    WRITEVU Rec ON DCusts, 'Xref', 1 SETTING Err ON ERROR
       CRT "I/O Error[" :Err: "]"
       ABORT
    END
