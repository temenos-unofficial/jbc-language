# WRITESEQ

WRITESEQ writes data to a file opened for sequential access.

## COMMAND SYNTAX

    WRITESEQ Expression { APPEND } ON | TO FileVar THEN | ELSE statements

## SYNTAX ELEMENTS

**Variable** specifies the variable to contain next record from sequential
file.

**FileVar** specifies the file descriptor of the file opened for sequential
access.

**Statements** are conditional jBC statements

## NOTES

Each WRITESEQ writes the data on a line of the sequentially opened file.
Each data is suffixed with a new line character. After each WRITESEQ, the
file pointer moves forward to the end of line. The WRITESEQF statement
forces each data line to be flushed to the file when it is written. The
APPEND option forces each WRITESEQ to advance to the end of the file
before writing the next data line.

## EXAMPLES

Create a file and write to it (overwriting contents each time):

       V.ID = 'report.txt'
       OPENSEQ '.', V.ID TO F.FILE.OUT THEN
          WEOFSEQ F.FILE.OUT  ;* truncate the file
       END
       WRITESEQ 'LINE 1' TO F.FILE.OUT ELSE
          CRT 'WRITE ERROR'
          STOP
       END
       CRT 'File ' : V.ID :  ' written'
       CLOSESEQ F.FILE.OUT

Append data to file:

       V.DIR.OUT = '.'
       V.FILE.OUT = 'time.log'
       OPENSEQ V.DIR.OUT, V.FILE.OUT TO F.FILE.OUT THEN NULL
       WRITESEQ TIMEDATE() APPEND TO F.FILE.OUT ELSE
          CRT 'Write error'
          STOP
       END

If file was opened in read only mode, WRITESEQ will fail and statements defined
after ELSE clause will be processed:

       IF NOT( GETENV('TAFC_HOME', tafc_home) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       //
       log_dir = tafc_home : '/tmp'
       log_file = 'jbase_error_trace'
       //
       OPENSEQ log_dir, log_file READONLY TO f_log THEN
       //
          FOR i = 1 TO 3   ;* read the first message
             READSEQ the_line FROM f_log ELSE BREAK
             CRT the_line
          NEXT i
       //
          WRITESEQ 'One more line' APPEND TO f_log ELSE
             CRT 'Write error'
             STOP
          END
       END ELSE
          CRT 'jbase_error_trace not found'
       END

Sample output:

<pre>
    &nbsp;
    Trace message from pid 3588 port 237 at 'Mon May 28 14:02:41 2012'
        Port 1 (Pid 6184) has been inactive for 34317875 seconds, Port cleared
    Write error</pre>
