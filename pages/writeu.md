# WRITEU

WRITEU statement allows a program to write a record into a
previously opened file. An existing record lock will be
preserved.

## COMMAND SYNTAX

    WRITEU variable1 ON | TO {variable2,} expression { SETTING setvar }  \
           { ON ERROR statements }

## SYNTAX ELEMENTS

**variable1** is the identifier holding the record to be
written.

**variable2**, if specified, should be a jBC variable that
has previously been opened to a file using the OPEN statement.
If variable2 is not specified then the default file is assumed.

The expression should evaluate to a valid record key for the file.

If the SETTING clause is specified and the write fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

If the statement fails to write the record then any statements
associated with the ON ERROR clause is executed.

The lock maintained by the [WRITEU](https://jbc-lang.org/pages/writeu.md) statement will be
released by any of the following events:

The same program with [WRITE](https://jbc-lang.org/pages/write.md), [WRITEV](https://jbc-lang.org/pages/writev.md) or
[MATWRITE](https://jbc-lang.org/pages/matwrite.md) statements writes to the record.

The record lock is released explicitly using the
[RELEASE](https://jbc-lang.org/pages/release.md) statement.

The program stops normally or abnormally.

See also: [READU](https://jbc-lang.org/pages/readu.md), [MATREADU](https://jbc-lang.org/pages/matreadu.md),
[RELEASE](https://jbc-lang.org/pages/release.md)

## EXAMPLE

       OPEN 'F.TEMP' TO F.TEMP ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE
             CRT 'OPEN FAILED'
             STOP
          END
       END
       READU V.REC FROM F.TEMP, 'REC1' LOCKED
          CRT 'Lock failure'
          STOP
       END ELSE NULL
       V.REC<-1> = 'A field'
       CRT RECORDLOCKED(F.TEMP, 'REC1')  ;* 2 - "Locked by this process by a READU"
       WRITEU V.REC TO F.TEMP, 'REC1'
       CRT RECORDLOCKED(F.TEMP, 'REC1')  ;* still 2
       RELEASE F.TEMP, 'REC1'
       CRT RECORDLOCKED(F.TEMP, 'REC1')  ;* 0 - not locked
