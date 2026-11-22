# BITLOAD

BITLOAD assigns all values in the local bit table, or retrieves all the
values.

## COMMAND SYNTAX

    BITLOAD({ bitstring })

## SYNTAX ELEMENTS

bit-string is an ASCII string of characters, which represent a
hexadecimal value. It is interpreted as a bit pattern and used to
assign values to the table from left to right. Assignment stops
at the end of the string or when a non-hexadecimal character
is found.

If the string represents less than 128 bits, the remaining bits in the
table are reset to 0 (zero).

If bit-string is omitted or evaluates to null, an ASCII hex character
string is returned, which defines the value of the table. Trailing
zeroes in the string are truncated.

## NOTES

A unique table of 128 bits (numbered 1 to 128) is maintained for each
process. Each bit in the table is treated as a two-state flag - the
value will always be 0 (zero) or 1.

## EXAMPLE 1

    VALUE.NEW = "0123456789ABCDEF"
    VALUE.OLD = BITLOAD(X)

Loads the bit table with the value of ASCII hex string NEW.VALUE
After assignment, the contents of the bit table is:

<pre>
    0000 0001 0010 0011
    0100 0101 0110 0111
    1000 1001 1010 1011
    1100 1101 1110 1111
    0000 0000 0000 0000
    0000 0000 0000 0000
    0000 0000 0000 0000
    0000 0000 0000 0000</pre>

**NOTE:** that all values beyond the 64th bit have been reset to 0 (zero).

## EXAMPLE 2

    TABLE.VALUE = BITLOAD()

Loads variable TABLE.VALUE with the hexadecimal values of the bit table
