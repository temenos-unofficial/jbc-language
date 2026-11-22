# DELETE

Use the DELETE statement to delete a record from a jBASE file.

## COMMAND SYNTAX

    DELETE {variable,} expression { SETTING setvar } { ON ERROR statements }

## SYNTAX ELEMENTS

If specified, variable should have been the subject of a previous
OPEN statement. If variable is omitted then it assumes the default
file variable.

The expression should evaluate to the name of a record stored in
the open file.

If the SETTING clause is specified and the delete fails, it sets
 setvar to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

The statement will have no effect if the record name does not
exist within the file.

If the program against the file record was holding a lock, it
will release the lock.

## EXAMPLE

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       WRITE V.REC.INIT TO F.TEMP, 'REC2'
       WRITE V.REC.INIT TO F.TEMP, 'REC3'
       DELETE F.TEMP, 'REC2' ON ERROR
          CRT 'DELETE ERROR'
          STOP
       END
    * "ON ERROR" part isn't triggered if a record doesn't exist
       DELETE F.TEMP, 'REC5' SETTING V.RET.CODE ON ERROR
          CRT 'REC5 - DELETE ERROR'
       END
       CLOSE F.TEMP
       EXECUTE 'LIST ONLY F.TEMP'

Output:

<pre>
    REC1
    REC3
     2 Records Listed</pre>

***TAFJ note: attempt to DELETE applied to non-valid file handle - session terminates. Example:***

       not_valid_filevar = ''
       DELETE not_valid_filevar, 'REC5' SETTING ret_code ON ERROR
           CRT 'REC5 - DELETE ERROR'
       END
       CRT STATUS() : '_' : ret_code   ;*  expected output: -1_32768
