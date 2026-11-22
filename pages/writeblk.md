# WRITEBLK

WRITEBLK statement writes a block of data to a file opened for
sequential processing.

## COMMAND SYNTAX

    WRITEBLK expression ON | TO file.variable { THEN statements [ ELSE statements ] \
           | ELSE statements}

## SYNTAX ELEMENTS

Each WRITEBLK statement writes the value of expression starting
at the current position in the file. The current position is
incremented to beyond the last byte written. WRITEBLK does not
add a new line at the end of the data.

**file.variable** specifies a file opened for sequential processing.

The value of expression is written to the file, and the THEN
statements are executed. If no THEN statements are specified,
program execution continues with the next statement. If the file
is neither accessible or does not exist, it executes the ELSE
statements; and ignores any THEN statements.

If either expression or file.variable evaluates to null, the WRITEBLK
statement fails and the program enters the debugger with a run-time
error message.

## INTERNATIONAL MODE

When using the WRITEBLK statement in International Mode, care must be
taken to ensure that the write variable is handled properly before the
WRITEBLK statement. The WRITEBLK statement expects the output variable
to be in "bytes", however when manipulating variables in International
Mode character length rather than byte lengths are usually used and
hence possible confusion or program malfunction can occur. If
requiring byte count data the output variable can be converted from
the UTF-8 byte sequence to 'binary/latin1' via the LATIN1 function.

It is not recommended that you use the [READBLK](https://jbc-lang.org/pages/readblk.md)/
[WRITEBLK](https://jbc-lang.org/pages/writeblk.md) statements when executing in International Mode.
You can obtain similar functionality via the [READSEQ](https://jbc-lang.org/pages/readseq.md)/
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md) statement, which can be used to read/write,
characters a line at a time from a file.

## NOTE

We have to explicitly create the output file if it doesnt exist (we didnt have to with
WRITESEQ, for example, under *prime* emulation).

## EXAMPLE

    * Create a file with random name and write to it
       V.ID = ''
       FOR V.J = 1 TO 8
          V.RND = RND(26) + 65
          V.ID := CHAR(V.RND)        ;* A...Z
       NEXT V.J
       V.ID := '.txt'
       OPENSEQ '.', V.ID TO  F.FILE.OUT THEN
          WEOFSEQ F.FILE.OUT  ;* truncate the file
       END ELSE  ;* will have to create - WRITEBLK wouldn't do that
          CREATE F.FILE.OUT ELSE
             CRT 'FILE CREATION FAILURE'
             STOP
          END
       END
       V.BUFFER = 'LINE 1' : CHAR(10) : 'LINE 2' : CHAR(10) : 'LINE 3'
       WRITEBLK V.BUFFER TO F.FILE.OUT ELSE
          CRT 'WRITE ERROR'
          STOP
       END
       CRT 'File ' : V.ID :  ' created'
       CLOSESEQ F.FILE.OUT
       STOP
    END
