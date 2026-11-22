# UTF8

UTF8 function converts a latin1 or binary string into the UTF-8
equivalent byte sequence.

## COMMAND SYNTAX

    UTF8(expression)

## SYNTAX ELEMENTS

The expression is expected to be a binary/latin1 code page string,
which is converted into a UTF-8 encoded byte sequence.

## EXAMPLE

       lat_line = CHAR(198) : CHAR(189) : CHAR(191)
       utf_line = UTF8(lat_line)
       FOR i = 1 TO 6 STEP 2
          CRT DTX( SEQ(utf_line[i,1]) ), DTX( SEQ(utf_line[i+1,1]) )
       NEXT i

The output of this program is:

<pre>
    C3 86 (latin capital letter ae)
    C2 BD (vulgar fraction one half)
    C2 BF (inverted question mark)</pre>

***TAFJ note: output is:***

<pre>
    C6 BD
    BF 0
    0 0</pre>

## NOTE

To run this example the following environment variables are to be set:

<pre>
    JBASE_I18N=1
    JBASE_CODEPAGE=utf8</pre>
