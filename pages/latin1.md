# LATIN1

LATIN1 function converts a UTF-8 byte sequence into the binary or latin1
equivalent.

## COMMAND SYNTAX

    LATIN1(expression)

## SYNTAX ELEMENTS

The expression is to be a UTF-8 encoded byte sequence, which is the
default format when executing in International Mode.

## EXAMPLE

       utf_line = CHAR( XTD('C3') )   \
             : CHAR( XTD('9F') )      \    ;* c3 9f: LATIN SMALL LETTER SHARP S
             : CHAR( XTD('C3') )      \
             : CHAR( XTD('9D') )    ;* c3 9d: LATIN CAPITAL LETTER Y WITH ACUTE
       lat_line = LATIN1(utf_line)
       CRT lat_line, SEQ(lat_line[1,1]), SEQ(lat_line[2,1])

The output of this program is:

<pre>
    &#223;&#221;    223     221</pre>

## NOTE

To run this example the following environment variables are to be set:

<pre>
    JBASE_I18N=1
    JBASE_CODEPAGE=utf8</pre>
