# LEN

LEN function returns the character length of the supplied expression.

## COMMAND SYNTAX

    LEN(expression)

## SYNTAX ELEMENTS

**expression** can evaluate to any type and the function will convert
it to a string automatically.

## INTERNATIONAL MODE

The LEN function will return the number of characters in the specified
expression rather than the number of bytes, in International Mode. If
the expression consists of entirely of UTF-8 characters in the ASCII
range 0 - 127 then the character length of the expression will equate
to the byte length. However, when the expression contains characters
outside the ASCII range 0 - 127 then byte length and character length
will differ. If the byte is specifically required then use the
[BYTELEN](https://jbc-lang.org/pages/bytelen.md) function in place of the LEN function.

## NOTES

Do not use programs manipulating byte counts in International Mode.

## EXAMPLE

    * Centered string output
       V.STRING = 'I AM IN THE VERY CENTER'   ; V.WIDTH = 50
       V.LEN = LEN(V.STRING)
       V.OFF.L = INT((V.WIDTH - V.LEN) / 2)    ;* left offset
       V.OFF.R = V.WIDTH - V.LEN - V.OFF.L     ;* right offset
       CRT SQUOTE( STR(' ', V.OFF.L) : V.STRING : STR(' ', V.OFF.R) )

Output is:

<pre>
    '             I AM IN THE VERY CENTER              '</pre>
