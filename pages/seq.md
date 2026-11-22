# SEQ

SEQ function returns numeric ASCII value of a character.

## COMMAND SYNTAX

    SEQ(expression)

## SYNTAX ELEMENTS

**expression** may evaluate to any data type. However, the SEQ function
will convert the expression to a string and operate on the first
character of that string.

## INTERNATIONAL MODE

The SEQ function will return numeric values beyond 255 for UTF-8 byte
sequences representing any Unicode values above 0x000000ff.

## EXAMPLE

    EQU ENQ TO 5
    * Get next comms code
    * Time-out after 20 seconds
    INPUT A, 1 FOR 200 ELSE BREAK
    IF SEQ(A) = ENQ THEN
    * Respond to ENQ char

## EXAMPLE 2

    * C5A1: Unicode Character 'LATIN SMALL LETTER S WITH CARON'
       CRT SEQ( ICONV('C5A1', 'MX') )
       CRT ICONV('C5A1', 'MX')

Output:

<pre>
    353
    &#353;</pre>
