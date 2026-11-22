# CHAR

The CHAR function returns the ASCII character specified by the
expression.

## COMMAND SYNTAX

    CHAR(expression)

## SYNTAX ELEMENTS

The expression must evaluate to a numeric argument in the range 0-255,
which is the entire ASCII character set.

## INTERNATIONAL MODE

The CHAR function will return Unicode values encoded as UTF-8 byte
sequences as follows:

Expression values 0 - 127 return UTF-8 single byte characters
equivalent to ASCII.

Expression values 127 - 248 return UTF-8 double byte character
sequences.

Expression values 249 - 255 return system delimiters 0xf8 - 0xff

Expression values > 255 return UTF-8 multi byte character
sequences

When system delimiter values are not specifically required,
generate UTF-8 byte sequences using the UTF8 function.
i.e. X = UTF8(@AM) will generate a UTF-8 byte sequence in variable X
for the system delimiter equating to Unicode value 0x000000fe.

## NOTES

jBC variables can contain any of the ASCII characters 0-255, thus there
are no restrictions on this function.

See also: [CHARS](https://jbc-lang.org/pages/chars.md)

## EXAMPLE

       EQUATE VM TO CHAR(253)         ;* value Mark
       FOR V.I = 1 TO 6
          CRT CHAR(64 + V.I):         ;* ABCDEF
       NEXT V.I
       CRT ''                         ;* starts a new line
       CRT OCONV( CHAR(353), 'MX' )   ;* C5A1
       CRT CHAR(7)                    ;* rings a bell
