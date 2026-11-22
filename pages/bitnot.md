# BITNOT

Use the BITNOT function to return the bitwise negation of an integer
specified by any numeric expression.

## COMMAND SYNTAX

    BITNOT(expression)

## DESCRIPTION

If expression evaluates to the null value, null is returned.

Non integer values are truncated before the operation is performed.
The BITNOT operation is performed on a 32-bit twos-complement word.

**NOTE:** Differences in hardware architecture can make the use of the
high-order bit non portable.

## EXAMPLE

    CRT BITNOT(6)     ;*  4294967289

Explanation of this example:

<pre>
    6 (decimal) = 110 (binary)
    Invert every bit (32-bit representation): 11111111111111111111111111111001
    Convert to decimal: 4294967289</pre>
