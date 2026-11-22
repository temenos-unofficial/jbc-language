# BITOR

Use the BITOR function to perform the bitwise OR comparison of two
integers specified by numeric expressions.

## COMMAND SYNTAX

    BITOR(expression1, expression2)

## DESCRIPTION

The bitwise OR operation compares two integers bit by bit. It returns
the bit 1 if the bit in either or both numbers is 1; else, it returns
the bit 0.

If either expression1 or expression2 evaluates to the null value, null
is returned.

Non integer values are truncated before the operation is performed.

The BITOR operation is performed on a 32-bit twos-complement word.

**NOTE:** Differences in hardware architecture can make the use of the
high-order bit non portable.

## EXAMPLE

       PRINT BITOR(6,12)
    * Binary value of 6 = 0110
    * Binary value of 12 = 1100

This results in 1110, and the following output is displayed:

<pre>
    14</pre>
