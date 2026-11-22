# OSREAD

OSREAD reads an OS file.

## COMMAND SYNTAX

    OSREAD Variable FROM expression { ON ERROR Statements }  \
          { THEN | ELSE } Statements

## SYNTAX ELEMENTS

**Variable** specifies the variable which is to be assigned to the
read data.

**Expression** specifies the full file path.  If the file resides in
the JEDIFILEPATH then just the file name is required.

**ON ERROR** Statements are conditional jBC statements to be executed
when the OSREAD statement fails with fatal error (because the file is
not open), I/O error, or jBASE cannot find the file. If you do not
specify the ON ERROR clause and a fatal error occurs, the program will
terminate.

THEN | ELSE:  If the OSREAD statement fails, it will execute any
statements associated with an ELSE clause. If the OSREAD is successful,
it will execute any statements associated with a THEN clause. Note that
the syntax requires either one or both of the THEN and ELSE clauses.

## WARNING

Do not use OSREAD on large files. The jBC OSREAD command reads an
entire sequential file and assigns the contents of the file to a
variable. If the file is too large for the program memory, the
program aborts and generates a runtime error message. On large files,
use [OSBREAD](https://jbc-lang.org/pages/osbread.md) or [READSEQ](https://jbc-lang.org/pages/readseq.md).
jBASE uses the ASCII 0 character (CHAR (0)) as a string-end delimiter.
ASCII 0 is not useable within string variable in jBC. This command
converts CHAR(0) to CHAR(128) when reading a block of data.

## NOTE

OSREAD doesn't include the LF character after the last line in the file
to the resulting variable:

***TAFJ note: OSREAD statement doesn't work - ELSE clause is always triggered.***

## EXAMPLE

       V.DIR.OUT = '.'  ;   V.FILE.OUT = 'report.txt'
       OPENSEQ V.DIR.OUT, V.FILE.OUT TO F.FILE.OUT THEN
          WEOFSEQ F.FILE.OUT
       END ELSE
          CREATE F.FILE.OUT ELSE CRT 'File create error'  ;  STOP
       END
       V.BUFFER = STR('.', 999)
       LOOP
          WRITESEQ V.BUFFER TO F.FILE.OUT ELSE CRT 'Write error'  ;  STOP
          V.FILE.SIZE = DIR(V.FILE.OUT)<1>
          CRT V.FILE.SIZE
       UNTIL V.FILE.SIZE GE 10000
       REPEAT
       CLOSESEQ F.FILE.OUT
       OSREAD V.ALL FROM V.FILE.OUT ELSE CRT 'Read error'  ;  STOP
       CRT LEN(V.ALL)
       CRT DQUOTE( RIGHT(V.ALL, 20) )

Output:

<pre>
    1000
    2000
    3000
    4000
    5000
    6000
    7000
    8000
    9000
    10000
    9999
    "...................."</pre>
