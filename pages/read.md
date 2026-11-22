# READ

READ statement allows a program to read a record from a previously
opened file into a variable.

## COMMAND SYNTAX

    READ variable1 FROM {variable2,} expression { SETTING setvar }  \
         { ON ERROR statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the identifier into which the record will be read.

**variable2**, if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement. If
variable2 is not specified then the default file is assumed.

The expression should evaluate to a valid record key for the file.

If the SETTING clause is specified and the reading process fails,
setvar will be set to one of the following values:

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

If you wish to set a lock on a record, you should do so explicitly
with the [READU](https://jbc-lang.org/pages/readu.md) statement.

## EXAMPLE

       IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       OPEN V.HOME : '/jbcmessages' TO F.MSG ELSE ABORT 201, 'jbcmessages'
       READ R.MSG FROM F.MSG, 'ARRAY_ILLEGAL_SIZE' ELSE
          CRT 'ERROR READING THE FILE, ID=ARRAY_ILLEGAL_SIZE'
          STOP
       END
       CRT R.MSG

Program output:

<pre>
    &lowast;&lowast; Error [ ARRAY_ILLEGAL_SIZE ] &lowast;&lowast; ^NEWLINE^^DEBUGQUIT^Attempt to DIMension
    a variable with 0 or fewer elements , Line ^LINENO^ , Source ^SOURCENAME^</pre>
