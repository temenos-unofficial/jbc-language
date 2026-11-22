# BITXOR

Use the BITXOR function to perform the bitwise XOR comparison of two
integers specified by numeric expressions. The bitwise XOR operation
compares two integers bit by bit. It returns a bit 1 if only one of
the two bits is 1; else, it returns a bit 0.

## COMMAND SYNTAX

    BITXOR(expression1, expression2)

## DESCRIPTION

If either expression1 or expression2 evaluates to the null value,
null is returned.

Non integer values are truncated before the operation is performed.

The BITXOR operation is performed on a 32-bit twos-complement word.

**NOTE:** Differences in hardware architecture can make the use of
the high-order bit nonportable.

## EXAMPLE

       PRINT BITXOR(6,12)
    * Binary value of 6 = 0110
    * Binary value of 12 = 1100

This results in 1010, and the following output is displayed:

<pre>
    10</pre>
