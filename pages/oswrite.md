# OSWRITE

The OSWRITE command writes the contents of an expression to a
sequential file.

## COMMAND SYNTAX

    OSWRITE expr { ON | TO } filename [ ON ERROR statements ]

## SYNTAX ELEMENTS

**expr** specifies the expression to be written into a file.

**ON | TO filename** specifies the name of a sequential file to
which the expression is to be written.

**ON ERROR** statements are statements to be executed when the
OSWRITE statement fails with fatal error (because the file is
not open), I/O error, or jBASE cannot find the file. If you do not
specify the ON ERROR clause and if a fatal error occurs, the program
will enter the debugger.

## NOTE

JBASE uses the ASCII 0 character [CHAR(0)] as a string-end delimiter.
For this reason, you cannot use ASCII 0 in any string variable in
jBASE. If jBASE reads a string with a CHAR(0) character, and then the
character is converted to CHAR(128), OSWRITE converts CHAR(128) to
CHAR(0) when writing a block of characters.

***TAFJ note: OSWRITE statement is not supported.***

## EXAMPLE

In the following example, the program segment writes the contents of
FOOTWEAR variable to the file called "PINK" in the
directory '/usr/local/myslippers'.

    OSWRITE FOOTWEAR ON "/usr/local/myslippers/PINK"
