# CHECKSUM

The CHECKSUM function returns a simple numeric checksum of a character
string.

## COMMAND SYNTAX

    CHECKSUM(expression)

## SYNTAX ELEMENTS

The expression may evaluate to any result but will usually be a string.
The function then scans every character in the string and sums up
the multiplication of character position by its ASCII value.
This algorithm doesn't really supply reliable result - see the example below.

## EXAMPLE

       CRT CHECKSUM('A')                ;* 65
       CRT CHECKSUM('AA')               ;* 65*1 + 65*2 = 195
       CRT CHECKSUM('B')                ;* 66
       CRT CHECKSUM( CHAR(0): '!' )     ;* 0*1 + 33*2 = 66
