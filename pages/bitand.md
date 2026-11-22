# BITAND

Use the BITAND function to perform the bitwise AND comparison of two
integers specified by numeric expressions.

## SYNTAX

    BITAND(expression1, expression2)

## DESCRIPTION

The bitwise AND operation compares two integers bit by bit. It returns
a bit of 1 if both bits are 1; else, it returns a bit of 0.

If either expression1 or expression2 evaluates to the null value, null
is returned.

Non integer values are truncated before the operation is performed.

The BITAND operation is performed on a 32-bit twos-complement word.

## NOTE

Differences in hardware architecture can make the use of the high-order
bit non portable.

## EXAMPLE

        PRINT BITAND(6,12)
        * The binary value of 6 = 0110
        * The binary value of 12 = 1100

This results in 0100, and the following output is displayed:

<pre>
    4</pre>
