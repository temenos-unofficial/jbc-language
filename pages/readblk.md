# READBLK

READBLK statement is used to read a block of data of a specified
length from a file opened for sequential processing and assign
it to a variable.

## COMMAND SYNTAX

    READBLK variable FROM file.variable, blocksize { THEN statements \
            [ ELSE statements ] | ELSE statements }

The READBLK statement reads a block of data beginning at the
current position in the file and continuing for blocksize bytes
and assigns it to variable. The current position is reset to just
beyond the last readable byte.

**file.variable** specifies a file previously opened for
sequential processing.

If the data can be read from the file, the THEN statements
are executed; any ELSE statements are ignored. If the file
is not readable or if the end of file is encountered, the ELSE
statements are executed and the THEN statements are ignored. If
the ELSE statements are executed, variable is set to an empty
string. If either file.variable or blocksize evaluates to null,
the READBLK statement fails and the program enters the debugger.

## INTERNATIONAL MODE

When using the READBLK statement in International Mode, care must
be taken to ensure that the input variable is handled properly
subsequent to the READBLK statement. The READBLK statement requires
that a "bytecount" be specified, however when manipulating variables
in International Mode character length rather than byte lengths are
usually used and hence possible confusion or program malfunction can
occur.

If requiring character data convert the input variable from
'binary/latin1' to UTF-8 byte sequence via the [UTF8](https://jbc-lang.org/pages/utf8.md)
function.

It is recommended that the [READBLK](https://jbc-lang.org/pages/readblk.md)/[WRITEBLK](https://jbc-lang.org/pages/writeblk.md)
statements not be used when executing in International Mode. Similar
functionality can be obtained via the
[READSEQ](https://jbc-lang.org/pages/readseq.md)/[WRITESEQ](https://jbc-lang.org/pages/writeseq.md) statement, which can be
used to read/writecharacters a line at a time from a file.

## NOTE

A new line in UNIX files is one byte long, whereas in Windows NT it is
two bytes long. This means that for a file with newlines, the same
READBLK statement may return a different set of data depending on the
operating system the file is stored under.

The difference between the [READSEQ](https://jbc-lang.org/pages/readseq.md) statement and the
READBLK statement is that the READBLK statement reads a block of
data of a specified length, whereas the READSEQ statement reads a
single line of data.

## EXAMPLE

       IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       V.FILE.IN = 'RELEASE'
       V.FILE.INFO = DIR(V.HOME : '/' : V.FILE.IN)
       V.SIZE = V.FILE.INFO<1>
       OPENSEQ V.HOME, V.FILE.IN TO F.FILE.IN ELSE
          CRT 'Failed to open', V.FILE.IN
          STOP
       END
       V.BLK.SIZE = MINIMUM(V.SIZE :@FM: 512)
       READBLK V.TEXT FROM F.FILE.IN, V.BLK.SIZE ELSE
          CRT 'Failed to read', V.FILE.IN
          STOP
       END
       CRT V.TEXT[1, INDEX(V.TEXT, CHAR(10), 1)]   ;* 1st line, e.g.:
                                                   ;* jBase Release : R11.0.0.0
