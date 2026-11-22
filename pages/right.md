# RIGHT

RIGHT function returns a sub-string composed of the last n characters
of a specified string.

## COMMAND SYNTAX

    RIGHT(expression, length)

## SYNTAX ELEMENTS

**expression** evaluates to the string from, which the sub string is
extracted.

**length** is the number of characters that are extracted. If length is
less than 1, RIGHT () returns null.

## NOTES

The RIGHT () function is equivalent to sub-string extraction for the
last n characters, i.e. expression[n]

See also: [LEFT](https://jbc-lang.org/pages/left.md)

## EXAMPLE

    S = "The world is my lobster"

    CRT DQUOTE( RIGHT(S,7))
    CRT DQUOTE( RIGHT(S,99) )
    CRT DQUOTE( RIGHT(S,0) )

This code displays:

<pre>
    "lobster"
    "The world is my lobster"
    ""</pre>
