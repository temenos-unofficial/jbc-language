# SEEK

SEEK statement is used to move the file pointer by an offset specified
in bytes, relative to the current position, the beginning of the file,
or the end of the file.

## COMMAND SYNTAX

    SEEK file.variable [ , offset [ , relto] ] { THEN statements  \
       [ ELSE statements ] | ELSE statements }

## SYNTAX ELEMENTS

**file.variable** specifies a file previously opened for sequential
access.

**offset** is the number of bytes before or after the reference
position. A negative offset results in the pointer being moved
before the position specified by relto. If offset is not
specified, 0 is assumed.

The permissible values of relto and their meanings follow:

| Value | Description                           |
|-------|---------------------------------------|
|0      | Relative to the beginning of the file |
|1      | Relative to the current position      |
|2      | Relative to the end of the file       |

If relto is not specified, 0 is assumed.

If the pointer is moved, the THEN statements are executed and the
ELSE statements are ignored. If the THEN statements are not
specified, program execution continues with the next statement.

If the file cannot be accessed or does not exist the ELSE
statements are executed; any THEN statements are ignored.

If file.variable, offset, or relto evaluates to null, the SEEK
statement fails and the program terminates with a run-time error
message.

## NOTES

In Windows-based systems, line endings in files are denoted by the
character sequence RETURN + LINEFEED rather than the single
LINEFEED used in UNIX files. The value of offset should take into
account this extra byte on each line in Windows NT file systems.

If you use the [OPENDEV](https://jbc-lang.org/pages/opendev.md) statement to open a
tape device for sequential processing, you
can move the file pointer only to the beginning or the end of the
data.

Seeking beyond the end of the file and then writing creates a gap,
or hole, in the file. This hole occupies no physical space, and
reads from this part of the file return as ASCII CHAR 0 (neither
the number nor the character 0).

For more information about sequential file processing, See also:
[OPENSEQ](https://jbc-lang.org/pages/openseq.md), [READSEQ](https://jbc-lang.org/pages/readseq.md), and
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md) statements.

## EXAMPLE

       V.DIR.OUT = '.'  ;   V.FILE.OUT = 'report.txt'
       OPENSEQ V.DIR.OUT, V.FILE.OUT TO F.FILE.OUT THEN
          WEOFSEQ F.FILE.OUT
       END ELSE
          CREATE F.FILE.OUT ELSE CRT 'File create error'  ;  STOP
       END
       WRITESEQ '1234567890ABCDEF' TO F.FILE.OUT ELSE
          CRT 'Write error'
          STOP
       END
    * go right after position 5 from the beginning
       SEEK F.FILE.OUT, 5, 0 ELSE CRT 'Seek error'  ;  STOP
       READSEQ V.STRING FROM F.FILE.OUT ELSE CRT 'Read error'  ;  STOP
       CRT V.STRING                 ;* 67890ABCDEF
    * go beyond end of file and write something there
       SEEK F.FILE.OUT, 3, 2 ELSE CRT 'Seek error'  ;  STOP
       WRITESEQ 'VWXYZ' TO F.FILE.OUT ELSE CRT 'Write error'  ;  STOP
       CLOSESEQ F.FILE.OUT
    * read full file contents
       OSREAD V.ALL FROM V.FILE.OUT ELSE CRT 'Read error'  ;  STOP
       CRT FMT( FMT( OCONV(V.ALL, 'MX'), '2L'), 'MCP ')
    * 31 32 33 34 35 36 37 38 39 30 41 42 43 44 45 46 FE 00 00 00 56 57 58 59 5A
