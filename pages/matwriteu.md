# MATWRITEU

MATWRITEU statement transfers the entire contents of a dimensioned
array to a specified record on file, in the same manner as the
MATWRITE statement. An existing record lock will be preserved.

## COMMAND SYNTAX

    MATWRITEU array TO | ON {variable,} expression { SETTING setvar }  \
            { ON ERROR statements }

## SYNTAX ELEMENTS

**array** should be a previously dimensioned and initialized
array. If specified, variable should be a previously opened file
variable (i.e. the subject of an OPEN statement). If variable is
not specified the default file variable is used.

**expression** should evaluate to the name of the record in the file.

If the SETTING clause is specified and the write succeeds, setvar
will be set to the number of attributes read into array.

If the SETTING clause is specified and the write fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If ON ERROR is specified, the statements following the ON ERROR
clause will be executed for any of the above Incremental File
Errors except error 128.

## NOTES

The compiler will check that the variable specified is indeed a
dimensioned array before its use in the statement.

## EXAMPLES

    DIM A(8)
    MAT A = 99
    ....
    MATWRITEU A ON "NewArray"
