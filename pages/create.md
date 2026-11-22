# CREATE

Use the CREATE statement after an [OPENSEQ](https://jbc-lang.org/pages/openseq.md) statement to
create a record in a jBASE directory file or to create a UNIX or
DOS file. CREATE creates the record or file if the [OPENSEQ](https://jbc-lang.org/pages/openseq.md)
statement fails.

An [OPENSEQ](https://jbc-lang.org/pages/openseq.md) statement for the specified file.variable must
be executed before the CREATE statement to associate the pathname or
record ID of the file to be created with the file.variable. If
file.variable is null, the CREATE statement fails and the program
enters the debugger.

Use the CREATE statement when [OPENSEQ](https://jbc-lang.org/pages/openseq.md) cannot find a record
or file to open and the next operation is to be a [READSEQ](https://jbc-lang.org/pages/readseq.md)
or [READBLK](https://jbc-lang.org/pages/readblk.md). If the first file operation is a
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md),it creates the record or file if it does not exist.

If the record or file is created, it executes the THEN statements;
if no record or file is created, it executes the ELSE statements.

## COMMAND SYNTAX

    CREATE file.variable { THEN statements [ ELSE statements ] | ELSE statements }

## EXAMPLE

In the following example, RECORD does not yet exist.
When [OPENSEQ](https://jbc-lang.org/pages/openseq.md) fails to open RECORD to the file variable FILE,
the CREATE statement creates RECORD in the type 1 file DIRFILE and opens
it to the file variable FILE.

    INCLUDE JBC.h
       out_dir = '.'  ;  out_file = 'report.txt'
       OPENSEQ out_dir, out_file TO f_out THEN
          WEOFSEQ f_out
       END ELSE
          CREATE f_out ELSE CRT 'File create error'  ;  STOP
          CRT 'File created'
       END
       WRITESEQ 'ABCDEFabcdef' TO f_out ELSE
          CRT 'Write error'
          STOP
       END
       CLOSESEQ f_out
       OSREAD the_content FROM out_dir : DIR_DELIM_CH : out_file ELSE NULL
       CRT the_content        ;* ABCDEFabcdef
