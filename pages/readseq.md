# READSEQ

READSEQ reads data from a file opened for sequential access.

## COMMAND SYNTAX

    READSEQ Variable FROM FileVar THEN | ELSE statements

## SYNTAX ELEMENTS

**Variable** specifies the variable to contain next record from sequential
file.

**FileVar** specifies the file descriptor of the file opened for sequential
access.

**Statements** are Conditional jBC statements.

## NOTES

Each READSEQ reads a line of data from the sequentially opened file. After
each READSEQ, the file pointer moves forward to the next line of data. The
variable contains the line of data less the new line character from the
sequential file.

The default buffer size for a READSEQ is 1024 bytes. This can be changed
using the IOCTL () function with the JIOCTL_COMMAND_SEQ_CHANGE_RECORDSIZE
Sequential File Extensions.

## EXAMPLE

## Step 1. Create a text file with long lines (1100 bytes each):

       OPENSEQ '.', 'test.txt' TO F.OUT.FILE THEN
          WEOFSEQ F.OUT.FILE
       END ELSE
          CREATE F.OUT.FILE ELSE
             CRT 'FILE CREATION ERROR'
             STOP
          END
       END
    * Create a ruler-like output
       V.LINE = ''
       FOR V.I = 1 TO 1100 STEP 10
          V.J = V.I + 9
          V.LINE := STR('-', 10 - LEN(V.J)) : V.J
       NEXT V.I
    * Now write it
       FOR V.I = 1 TO 10
          WRITESEQ V.LINE TO F.OUT.FILE ELSE
             CRT 'FILE WRITE ERROR'
             STOP
          END
       NEXT V.I

Line ends in this file are shown here (JED, Ctrl-E to go to line end):

<pre>
    0001 ------1050------1060------1070------1080------1090------1100
    0002 ------1050------1060------1070------1080------1090------1100
    0003 ------1050------1060------1070------1080------1090------1100
    0004 ------1050------1060------1070------1080------1090------1100
    0005 ------1050------1060------1070------1080------1090------1100
    0006 ------1050------1060------1070------1080------1090------1100
    0007 ------1050------1060------1070------1080------1090------1100
    0008 ------1050------1060------1070------1080------1090------1100
    0009 ------1050------1060------1070------1080------1090------1100
    0010 ------1050------1060------1070------1080------1090------1100
    -------------------------------- End Of Record --------------------------------</pre>

## Step 2. Read a line from this text file using plain READSEQ:

       OPENSEQ '.', 'test.txt' TO F.IN.FILE THEN
          NULL
       END ELSE
          CRT 'ERROR OPENING FILE'
          STOP
       END
       READSEQ V.LINE FROM F.IN.FILE ELSE
          CRT 'ERROR READING FILE'
          STOP
       END
       CRT LEN(V_LINE) : '_' : V.LINE[-20,20]                   ;*  1024_--1010------1020----

***Quite rare positive TAFJ note: output is:***

<pre>
    1100_------1090------1100</pre>

So there's no limit of 1024.

## Step 3. Read a line from this text file using IOCTL() first:

    INCLUDE JBC.h
       OPENSEQ '.', 'test.txt' TO F.IN.FILE THEN
          NULL
       END ELSE
          CRT 'ERROR OPENING FILE'
          STOP
       END
       IF IOCTL(F.IN.FILE, JIOCTL_COMMAND_SEQ_CHANGE_RECORDSIZE, 2048) THEN
          NULL
       END ELSE
          CRT 'IOCTL FAILED !!!'
          STOP
       END
       READSEQ V.LINE FROM F.IN.FILE ELSE
          CRT 'ERROR READING FILE'
          STOP
       END
       CRT LEN(V.LINE)                      ;*  1100
       CRT V.LINE[-20,20]                   ;*  ------1090------1100

## Step 3 (alternate). Use subsequent READSEQs to read that file:

       OPENSEQ '.', 'test.txt' TO F.IN.FILE THEN
          NULL
       END ELSE
          CRT 'ERROR OPENING FILE'
          STOP
       END
       V.EOF = ''
       LOOP
          V.LINE = ''
          LOOP
             READSEQ V.CHUNK FROM F.IN.FILE ELSE
                V.EOF = 1
                BREAK
             END
             V.LEN = BYTELEN(V.CHUNK)
             V.LINE := V.CHUNK
             IF V.LEN LT 1024 THEN BREAK
          REPEAT
    * Line processing goes here
          IF V.EOF THEN BREAK
          CRT LEN(V.LINE)                      ;*  1100
          CRT V.LINE[-20,20]                   ;*  ------1090------1100
       REPEAT
