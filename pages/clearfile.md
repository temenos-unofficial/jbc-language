# CLEARFILE

Use the CLEARFILE statement to clear all the data from a file previously
opened with the OPEN statement.

## COMMAND SYNTAX

    CLEARFILE { variable } { SETTING setvar } { ON ERROR statements }

## SYNTAX ELEMENTS

The variable should be the subject of an OPEN statement before the
execution of CLEARFILE upon it. If the variable is omitted from the
CLEARFILE statement, it assumes the default file variable as per the
OPEN statement.

## NOTES

The CLEARFILE statement will remove every database record on the file
against which it is executed, therefore, use with caution.

If the variable argument does not describe a previously opened file,
the program will enter the debugger with an appropriate message.

If the SETTING clause is specified and the CLEARFILE fails, it sets
setvar to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## EXAMPLE

       OPEN 'F.TEMP' TO F.TEMP THEN
          V.ERR = ''
          CLEARFILE F.TEMP SETTING V.ERR
          IF V.ERR NE '' THEN
             CRT 'ERROR ' : V.ERR
             STOP
          END
          CRT 'FILE CLEARED'
       END ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       END
