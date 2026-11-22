# OSBWRITE

OSBWRITE command writes an expression to a sequential file starting at a
specified byte location.

## COMMAND SYNTAX

    OSBWRITE expr { ON | TO } file.var [ AT byte.expr ] [ NODELAY ]  \
             [ ON ERROR statements ]

OSBWRITE immediately writes a file segment out to the UNIX, Windows
NT, or Windows 2000 file. There is no necessity to specify a length
expression because the number of bytes in expr is already written to
the file.

OSBWRITE converts CHAR (128) back to CHAR(0) when writing a block of
characters.

## SYNTAX ELEMENTS

**expr** specifies the expression to be written in the file.

**ON | TO file.var** specifies the file on which the expression is to
be written.

**AT byte.expr** specifies the byte number from where the expression
is to be written. For example, if byte.expr is 0, then the expression
is written in the beginning of the file.

**NODELAY** forces an immediate write.

**ON ERROR statements** are the statements executed if the OSBWRITE
statement fails with fatal error, I/O error, or jBASE cannot find the
file. If you do not specify the ON ERROR clause and a fatal error
occurs, the program will terminate.

*STATUS Function Return Values*

After you execute OSBWRITE, the STATUS function returns either 0 or
a failure code.

| Code | Description               |
|------|---------------------------|
|0     | The write was successful. |
|1     | The write failed.         |

## NOTES

Before you use OSBWRITE, you must open the file by using the OSOPEN or
OPENSEQ command.

jBASE uses the ASCII 0 character [CHAR (0)] as a string-end delimiter.
Therefore, ASCII 0 cannot be used in any string variable within jBASE.
If jBASE reads a string that contains CHAR(0) characters by using
OSBREAD, those characters are converted to CHAR(128).

***TAFJ note: OSBWRITE statement isn't supported.***

## EXAMPLE

In the following example, the program statement writes the data in MYPIPE
to the opened file starting from the beginning of the file:

    OSBWRITE Data ON MYPIPE AT 0
