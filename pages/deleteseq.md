# DELETESEQ

DELETESEQ deletes a sequential file.

## COMMAND SYNTAX

    DELETESEQ Expression, Filename { SETTING setvar } { ON ERROR statements } \
    { LOCKED statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**Expression** specifies the location of sequential file.

**Filename** specifies the sequential file name.

**Statements** conditional jBC statements

## EXAMPLE

Has to be put into file *test.b*.

       EXECUTE 'COPY FROM . test.b,temp.txt OVERWRITING'
       *
       OPENSEQ '.', 'temp.txt' TO temp_file ELSE
          CRT 'Failed to open temporary file'
          STOP
       END
       *
       READSEQ first_line FROM temp_file ELSE
          CRT 'Failed to read temporary file'
          STOP
       END
       *
       CRT first_line        ;* EXECUTE 'COPY FROM . test.b,temp.txt OVERWRITING'
       CLOSESEQ temp_file
       CRT DIR('temp.txt')<1>           ;* e.g. 540 - size of file
       *
       DELETESEQ '.', 'temp.txt' ELSE NULL
       CRT '<' : DIR('temp.txt')<1> : '>'          ;* <>

***TAFJ note: statements on ELSE clause aren't executed.***
