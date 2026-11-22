# FLUSH

Writes all the buffers for a sequential I/O file immediately. Normally,
sequential I/O uses buffering for input/output operations, and writes
are not immediately flushed.

## COMMAND SYNTAX

    FLUSH file.variable { THEN statements [ ELSE statements ] | ELSE statements }

**file.variable** specifies a file previously opened for sequential
processing. If file.variable evaluates to null, the FLUSH statement
fails and the program enters the debugger. After the buffer is written
to the file, it executes the THEN statements, ignoring the ELSE
statements.

If none of the above can be completed, it executes the ELSE
statements.

## EXAMPLE

       dir_name = '.'
       file_name = 'report.txt'
       DELETESEQ dir_name, file_name ELSE NULL
       *
       OPENSEQ dir_name, file_name TO f_report ELSE NULL
       WRITESEQ 'New data' TO f_report ELSE NULL
       *
       FLUSH f_report ELSE NULL
       CRT '<' : DIR(file_name)<1> : '>'     ;* 9

## NOTE

For **prime** emulation FLUSH in this example will fail if there were still no
WRITESEQs since file isn't created immediately on OPENSEQ:

       dir_name = '.'
       file_name = 'report.txt'
       DELETESEQ dir_name, file_name ELSE NULL
       *
       OPENSEQ dir_name, file_name TO f_report ELSE NULL
       *
       FLUSH f_report ELSE NULL
       CRT '<' : DIR(file_name)<1> : '>'     ;* 0

This program will crash with the following message:

<pre>
    &lowast;&lowast; Error [ NOT_FILE_VAR ] &lowast;&lowast;
    Variable is not an opened file descriptor , Line     7 , Source test.b
    Trap from an error message, error message name = NOT_FILE_VAR</pre>

Under **seq** emulation program will not crash.
