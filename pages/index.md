# INDEX

The INDEX function will return the position of a character or
characters within another string.

## COMMAND SYNTAX

    INDEX(expression1, expression2, expression3)

## SYNTAX ELEMENTS

**expression1** evaluates to the string to be searched.

**expression2** evaluates to the string or character that will
be searched for within expression1.

**expression3** should evaluate to a numeric value and specify
which occurrence of expression2 should be searched for within
expression1.

## NOTES

If the specified occurrence of expression2 is not found in
expression1 then it returns Zero (0).

## EXAMPLE

    ABet = "abcdefghijklmnopqrstuvwxyzabc"
    CRT INDEX(ABet, 'a', 1)
    CRT INDEX(ABet, 'a', 2)
    CRT INDEX(ABet, 'jkl', 1)

The above code will display:

<pre>
    1
    27
    10</pre>
