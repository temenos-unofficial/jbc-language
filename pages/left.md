# LEFT

The LEFT function extracts a sub-string of a specified length from the
beginning of a string.

## COMMAND SYNTAX

    LEFT(expression, length)

## SYNTAX ELEMENTS

**expression** evaluates to the string from which the sub string is
extracted.

**length** specifies the number of the extracted characters. If the
length is less than 1, then LEFT() returns null.

## NOTES

The LEFT() function is equivalent to sub-string extraction starting
from the first character position, i.e. expression[1,length]

See also: [RIGHT](https://jbc-lang.org/pages/right.md)

## EXAMPLES

    S = "The world is my lobster"
    CRT DQUOTE( LEFT(S,9) )
    CRT DQUOTE( LEFT(S,999) )
    CRT DQUOTE( LEFT(S,0) )

This code displays:

<pre>
    "The world"
    "The world is my lobster"
    ""</pre>
