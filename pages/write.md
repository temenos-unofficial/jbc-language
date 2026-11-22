# WRITE

WRITE statement allows a program to write a record into a previously
opened file.

## COMMAND SYNTAX

    WRITE variable1 ON | TO {variable2,} expression { SETTING setvar }  \
          { ON ERROR statements }

## SYNTAX ELEMENTS

**variable1** is the identifier containing the record to be written.

**variable2**, if specified, should be a previous opened jBC
variable to a file using the OPEN statement. If not specifying
variable2 then it assumes the default file.

The expression should evaluate to a valid record key for the
file.

If specifying the SETTING clause and the write fails, it sets
setvar to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

If holding a lock on the record by this process, it is released
by the WRITE.
If you wish to retain a lock on a record, you should do so
explicitly with the [WRITEU](https://jbc-lang.org/pages/writeu.md) statement.

## EXAMPLE

       OPEN 'F.TEMP' TO F.TEMP THEN
          NULL
       END ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       END
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       CLOSE F.TEMP
