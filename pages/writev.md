# WRITEV

WRITEV statement allows a program to write a specific field
of a record in a previously opened file.

## COMMAND SYNTAX

    WRITEV variable1 ON | TO {variable2,} expression1, expression2  \
         { SETTING setvar } { ON ERROR statements }

## SYNTAX ELEMENTS

**variable1** is the identifier holding the record to be written.

**variable2**, if specified, should be a jBC variable that
has previously been opened to a file using the OPEN statement.
If variable2 is not specified then it assumes the default file.

**expression1** should evaluate to a valid record key for the file.

**expression2** should evaluate to a positive integer number. If
the number is greater than the number of fields in the record, it
will add null fields to variable1. If expression2 evaluates to a
non-numeric argument, it will generate a run time error.

If the SETTING clause is specified and the write fails, it sets
setvar to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

The WRITEV statement will cause the release of any lock held on
the record by this program. If you wish to retain a lock on the
record, do so explicitly with the WRITEVU statement.

## EXAMPLE

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO f_temp ELSE ABORT 201, 'F.TEMP'
       new_rec = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE new_rec TO f_temp, 'REC1'
       WRITEV 'LINE 2v2' TO f_temp, 'REC1', 2 ON ERROR
          CRT 'WRITEV error'
          STOP
       END
       EXECUTE "I-DUMP F.TEMP 'REC1'"     ;* "REC1^LINE 1^LINE 2v2^LINE 3^"
       WRITEV 'LINE 7' TO f_temp, 'REC1', 7 ON ERROR
          CRT 'WRITEV error'
          STOP
       END
       EXECUTE "I-DUMP F.TEMP 'REC1'"     ;* "REC1^LINE 1^LINE 2v2^LINE 3^^^^LINE 7^"
