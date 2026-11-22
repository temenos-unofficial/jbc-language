# BITRESET

BITRESET resets the value of a specified bit in the local bit table to
zero and returns the previous value of the bit.

## COMMAND SYNTAX

    BITRESET(table_no)

## SYNTAX ELEMENTS

table_no specifies the position in the table of the bit for reset. If
table_no evaluates to zero, it resets all elements in the table to
zero and returns the value zero.

## NOTES

For each process, it maintains a unique table of 128 bits (numbered 1
to 128) and treats each bit in the table as a two-state flag - the
value returned will always be zero or one.

BITRESET returns the previous value of the bit - you can reset and
check a flag in one step.

BITRESET also provides some special functions if you use one of the
following table_no values:

|Code|  Description                             |
|----|------------------------------------------|
|-1  | resets the BREAK key Inhibit bit.        |
|-2  | resets the Command Level Restart feature.|
|-3  | resets the Break/End Restart feature.    |

See also: [BITSET](https://jbc-lang.org/pages/bitset.md)

## EXAMPLE

        OLD.VALUE = BITRESET(112)
        PRINT OLD.VALUE

If table entry 112 is one, it returns a value of one, resets bit 112
to 0, and prints one. If table entry 112 is zero, returns a value of
0, and prints 0.
