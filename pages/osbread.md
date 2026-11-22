# OSBREAD

OSBREAD command reads data from a file starting at a specified byte
location for a certain length of bytes, and assigns the data to a
variable.

## COMMAND SYNTAX

    OSBREAD var FROM file.var [ AT byte.expr ] LENGTH length.expr  \
            [ ON ERROR statements ]

OSBREAD performs an operating system block read on a UNIX or
Windows file.

## SYNTAX ELEMENTS

**var** specifies a variable to which the data read is assigned.

**FROM file.var** specifies a file from which the data is read.

**AT byte.expr** specifies a location inside the file from where
the data reading operation is to start. If byte.expr is 0, the
read begins at the beginning of the file.

**LENGTH length.expr** specifies length of data to be read from the
file, starting at byte.expr. length.expr cannot be longer than the
maximum string length determined by your system configuration.

**ON ERROR statements** are statements executed if a fatal error
occurs (if the file is not open, or if the file is a read-only
file). If you do not specify the ON ERROR clause, the program will
terminate under such fatal error conditions.

*STATUS Function Return Values*
After you execute OSBREAD, the STATUS function returns either 0 or
a failure code.

## NOTE

Before you use OSBREAD, you must open the file by using the
[OSOPEN](https://jbc-lang.org/pages/osopen.md) or [OPENSEQ](https://jbc-lang.org/pages/openseq.md) command.

jBASE uses the ASCII 0 character [CHAR (0)] as a string-end delimiter.
Therefore, ASCII 0 cannot be used in any string variable within jBASE.
OSBREAD converts CHAR(0) to CHAR(128) when reading a block of data.

## EXAMPLE

In the following example, the program test.b reads itself and outputs its
contents to the screen:

       OSOPEN 'test.b' TO MYFILE ELSE STOP
       OSBREAD Data FROM MYFILE AT 0 LENGTH 10000
       CRT Data

***TAFJ note: if we use a variable for LENGTH, routine won't even compile:***

<pre>    expecting "LENGTH", found 'max_len' Probably due to unclosed Block.
   Please verify that all 'IF' has a 'END'</pre>

***TAFJ R23 note: if the last CRLF is missing in a file, last data byte is truncated:***

File test.txt (no CRLF in "Line 3"):

    Line 1
    Line 2
    Line 3

Test routine:

       OSOPEN 'test.txt' TO f_in ELSE
           CRT 'Open error'
           STOP
       END
       *
       OSBREAD data FROM f_in AT 0 LENGTH 100000 ON ERROR
           ret_stat = STATUS()
           CRT 'Read error (status = ' : DQUOTE(ret_stat) : ')'
           STOP
       END
       *
       OSCLOSE f_in
       CRT DQUOTE(data)
       STOP
       END

Output - TAFC:

    "Line 1
    Line 2
    Line 3"

Output - TAFJ:

    "Line 1
    Line 2
    Line "
