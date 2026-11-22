# READVU

READVU statement allows a program to read a specific field in a
record in a previously opened file into a variable. It also respects
record locking and locks the specified record for update.

## COMMAND SYNTAX

    READVU variable1 FROM {variable2,} expression1, expression2 { SETTING setvar }  \
           { ON ERROR statements } { LOCKED statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the identifier into which the record will be
read.

**variable2** if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement. If
variable2 is not specified then the default file is assumed.

**expression1** should evaluate to a valid record key for the file.

**expression2** should evaluate to a positive integer number. If
the number is invalid or greater than the number of fields in the
record, then a NULL string will be assigned to variable1. If the
number is 0, then the readv0 emulation setting controls the value
returned in variable1. If a non-numeric argument is evaluated a run
time error will occur.

If the SETTING clause is specified and the read fails, setvar will
be set to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If ON ERROR is specified, the statements following the ON ERROR clause
will be executed for any of the above Incremental File Errors except
error 128.

## NOTES

If the record could not be read because another process already had a
lock on the record then one of two actions is taken. If the LOCKED clause
was specified in the statement then the statements dependent on it are
executed. If no LOCKED clause was specified then the statement blocks
(hangs) until the other process releases the lock.

If the statement fails to read the record then any statements associated
with the ELSE clause are executed. If the statement successfully reads the
record then the statements associated with any THEN clause are executed.
Either or both of the THEN and ELSE clauses must be specified with the
statement.

The lock taken by the [READVU](https://jbc-lang.org/pages/readvu.md) statement will be released by any
of the following events:

The same program with [WRITE](https://jbc-lang.org/pages/write.md), [WRITEV](https://jbc-lang.org/pages/writev.md),
[MATWRITE](https://jbc-lang.org/pages/matwrite.md) or [DELETE](https://jbc-lang.org/pages/delete.md) statements writes to the
record.

The record lock is released explicitly using the [RELEASE](https://jbc-lang.org/pages/release.md)
statement.

The program stops normally or abnormally.

When a file is OPENed to a local file variable in a subroutine then the
file is closed when the subroutine RETURNS so all locks taken on that
file are released, including locks taken in a calling program. Files
that are opened to [COMMON](https://jbc-lang.org/pages/common.md) variables are not closed so the
locks remain intact.

See also: [WRITE](https://jbc-lang.org/pages/write.md), [WRITEU](https://jbc-lang.org/pages/writeu.md), [MATWRITE](https://jbc-lang.org/pages/matwrite.md),
[MATWRITEU](https://jbc-lang.org/pages/matwriteu.md), [RELEASE](https://jbc-lang.org/pages/release.md), and [DELETE](https://jbc-lang.org/pages/delete.md)

## EXAMPLE

    OPEN "Customers" ELSE ABORT 201, "Customers"
    OPEN "DICT Customers" TO DCusts ELSE
    	    ABORT 201, "DICT Customers"
    END
    LOOP
    	    READVU Rec FROM DCusts, "Xref",7 LOCKED
        	  CRT "Locked - retrying"
        	  SLEEP 1; CONTINUE ;* Restart LOOP
    	    END THEN
            READ DataRec FROM Rec ELSE
                ABORT 202, Rec
           END
           BREAK ;*leave the LOOP
       END ELSE
           ABORT 202, "Xref"
       END
    REPEAT
