# SEQS

SEQS function is used to convert a dynamic array of ASCII characters to
their numeric string equivalents.

## COMMAND SYNTAX

    SEQS(dynamic.array)

## SYNTAX ELEMENTS

**dynamic.array** specifies the ASCII characters to be converted. If
dynamic.array evaluates to null, it returns null. If any element of
dynamic.array is null, it returns null for that element.

If you use the subroutine syntax, the resulting dynamic array is
returned as return.array.

By using the SEQS function to convert a character outside its range
results in a run-time message, and the return of an empty string.

## INTERNATIONAL MODE

The SEQS function will return numeric values beyond 255 for UTF-8 byte
sequences representing any Unicode values above 0x000000ff.

## EXAMPLE

    G = 'T' :@VM: "G"
    A = SEQS(G)
    PRINT A
    PRINT SEQS('G')

The output of this program is:

<pre>
    84]71 71</pre>

***TAFJ note: SEQS() function isn't supported.***
