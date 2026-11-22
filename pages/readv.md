# READV

READV statement allows a program to read a specific field from a
record in a previously opened file into a variable.

## COMMAND SYNTAX

    READV variable1 FROM { variable2,} expression1, expression2 { SETTING setvar }  \
         { ON ERROR statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the identifier into which the record will be read.

**variable2** if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement. If
variable2 is not specified, the default file is assumed.

**expression1** should evaluate to a valid record key for the
file.

**expression2** should evaluate to a positive integer. If the
number is invalid or greater than the number of fields in the
record, a NULL string will be assigned to variable1. If the
number is 0, then the readv0 emulation setting controls the
value returned in variable1. If a non-numeric argument is
evaluated, a run time error will occur.

If the SETTING clause is specified and the read fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If ON ERROR is specified, the statements following the ON ERROR
clause will be executed for any of the above Incremental File
Errors except error 128.

## NOTES

If you wish to set a lock on a record, do so explicitly with the
[READU](https://jbc-lang.org/pages/readu.md) or [READVU](https://jbc-lang.org/pages/readvu.md) statement. To read a field
from a previously opened file into a variable and take a read-only
shared lock on the field, use [READVL](https://jbc-lang.org/pages/readvl.md).

## EXAMPLE

       OPEN 'F.TEMP' TO f_temp THEN
          ret_error = ''
          CLEARFILE f_temp SETTING ret_error
          IF ret_error NE '' THEN
             CRT 'ERROR ' : ret_error
             STOP
          END
       END ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO f_temp ELSE ABORT 201, 'F.TEMP'
       END
       *
       out_record = 'Field 1' :@FM: 'Field 2' :@FM: 'Field 3'
       WRITE out_record TO f_temp, 'REC1'
       *
       READV second_field FROM f_temp, 'REC1', 2 ELSE
          CRT 'Read error'
          STOP
       END
       *
       CRT second_field           ;*  Field 2
