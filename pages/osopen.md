# OSOPEN

OSOPEN command opens a sequential file that does not use CHAR (10) as
the line delimiter.

## COMMAND SYNTAX

    OSOPEN filename TO file.var [ ON ERROR statements ] { THEN | ELSE } statements

Read/write access mode is the default. Override this access mode by
using READONLY and WRITEONLY.

## SYNTAX ELEMENTS

**filename** specifies the file to be opened. Filename must include
the entire path name unless the file resides in the current directory.

**TO file.var** specifies a variable to contain a pointer to the file.

**ON ERROR** statements are statements executed when the OSOPEN
statement fails with fatal error, I/O error, or JBASE cannot find
the file. If you do not specify the ON ERROR clause and a fatal
error occurs, the program will enter the debugger.

**THEN** statements executes if the read is successful.

**ELSE** statements executes if the read is not successful or the
record (or ID) does not exist.

## NOTES

After opening a sequential file with [OSOPEN](https://jbc-lang.org/pages/osopen.md), use
[OSBREAD](https://jbc-lang.org/pages/osbread.md) to read a block of data from the file, or
[OSBWRITE](https://jbc-lang.org/pages/osbwrite.md) to write a block of data to the file. You also
can use [READSEQ](https://jbc-lang.org/pages/readseq.md) to read a record from the file, or
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md) or [WRITESEQF](https://jbc-lang.org/pages/writeseqf.md) to write a record to
the file, if the file is not a named pipe. ([READSEQ](https://jbc-lang.org/pages/readseq.md),
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md), [WRITESEQF](https://jbc-lang.org/pages/writeseqf.md) are line-oriented
commands that use CHAR (10) as the line delimiter.)

## EXAMPLE

In the following example, the program statement opens the file
'MYSLIPPERS' as SLIPPERS.

    OSOPEN 'MYSLIPPERS' TO SLIPPERS ELSE STOP
