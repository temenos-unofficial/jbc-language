# XTD

XTD function converts hexadecimal numbers into its decimal equivalent.

## COMMAND SYNTAX

    XTD(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a valid hexadecimal string.

## NOTES

The conversion process will halt at the first character that is not a
valid base 16 character in the set [0-9, A-F or a-f].

See also: [DTX](https://jbc-lang.org/pages/dtx.md).

## EXAMPLES

       CRT XTD('FF')                                          ;* 255
       CRT FMT( DTX(13), 'R%2' ) : FMT( DTX(10), 'R%2' )      ;* 0D0A
       CRT XTD('BADBEEF')  ;*  195935983 (binary: 00001011101011011011111011101111)
       CRT XTD('DEADBEEF') ;* -559038737 (binary: 11011110101011011011111011101111)
       CRT XTD('1aGHI')    ;* 26 - stopped after processing "1a"
       CRT XTD('GHI')      ;* 0

## NOTE

Negative result in line 4 is caused by the first bit of binary result
being set.

***TAFJ note: XTD('1aGHI') results in 0, not 26.***

***TAFJ R23 note: XTD('DEADBEEF') returns 0.***
