# BITCHECK

BITCHECK returns the current value of a specified bit from the local
bit table.

## COMMAND SYNTAX

    BITCHECK(table_no)

## SYNTAX ELEMENTS

table_no specifies the position in the table of the bit for checking.

## NOTES

For each process, it maintains a unique table of 128 bits (numbered 1
to 128) and treats each bit in the table as a two-state flag - the
value returned will always be zero or one.
