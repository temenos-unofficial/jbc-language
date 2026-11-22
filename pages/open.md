# OPEN

OPEN statement is used to open a file or device to a descriptor
variable within jBC.

## COMMAND SYNTAX

    OPEN {expression1,}expression2 TO {variable} { SETTING setvar } \
         THEN | ELSE statements

## SYNTAX ELEMENTS

The combination of **expression1** and **expression2** should evaluate
to a valid file name of a file type that already installed on the
jBASE system. If the file has a dictionary section to be opened by the
statement then specify by the literal string "DICT" being specified in
expression1. If specified, the variable will be used to hold the
descriptor for the file. It should then be to access the file using
READ and WRITE. If no file descriptor variable is supplied, then the
file will be opened to the default file descriptor.

Specific data sections of a multi level file may be specified by
separating the section name from the file name by a "," char in
expression2.

If the OPEN statement fails, it will execute any statements associated
with an ELSE clause. If the OPEN is successful, it will execute any
statements associated with a THEN clause. Note that the syntax requires
either one or both of the THEN and ELSE clauses.

If specifying the SETTING clause and the open fails, setvar will be set
to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

The OPEN statement uses the environment variable JEDIFILEPATH to search
for the named file. If there is no defined named file, it will search
the current working directory followed by the home directory of the
current process.
The file that is the subject of the OPEN statement can be of any type
known to the jBASE system. Its type will be determined and correctly
opened transparently to the application, which need not be aware of
the file type.

A jBC program can open an unlimited amount of files (up the limit set by
OS settings).

## EXAMPLE

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       CLOSE F.TEMP

## EXAMPLE 2

Get list of current processes and output port number and PID for each:

       OPEN SYSTEM(1027) TO PROC ELSE STOP 201, "PROC"
       SELECT PROC TO SEL
       LOOP
       WHILE READNEXT key FROM SEL DO
          READ PROCESSRECORD FROM PROC, key ELSE CRT "Read Error"  ;  STOP
          V.PORTNO = PROCESSRECORD<1>
          V.PID = PROCESSRECORD<4>
          PRINT FMT(V.PORTNO, '2R') : '|' : FMT(V.PID, '8R')
       REPEAT
