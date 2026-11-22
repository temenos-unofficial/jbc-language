# FOLD

The FOLD function re-delimits a string by replacing spaces with
attribute marks at positions defined by a length parameter.

## COMMAND SYNTAX

    FOLD(expression1, expression2)

## SYNTAX ELEMENTS

**expression1** evaluates a string to be re-delimited.

**expression2** evaluates to a positive integer that represents
the maximum number of characters between delimiters in the
resultant string.

## NOTES

The FOLD function creates a number of sub-strings such that the
length of each sub-string does not exceed the length value in
expression2. It converts spaces to attribute marks except when
enclosed in sub-strings and removes extraneous spaces.

## EXAMPLES

The following examples show how the FOLD function delimits
text based on the length parameter. The underscores represent
attribute marks.

    q = "Smoking is one of the leading causes of statistics"
    CRT OCONV( FOLD(q, 7), 'MCP' )

Output:
<pre>
    Smoking^is one^of the^leading^causes^of^statist^ics</pre>

    q = "Hello world"
    CRT OCONV( FOLD(q, 5), 'MCP' )

Output:
<pre>
    Hello^world</pre>

    q = "Let this be a reminder to you all" \
        : " that this organization will not tolerate failure."
    CRT OCONV( FOLD(q, 30), 'MCP')

Output:

<pre>
Let this be a reminder to you^all that this organization^will not tolerate failure.</pre>

    q = "the end"
    CRT OCONV( FOLD(q, 0), 'MCP' )

Output:
<pre>
    t^h^e^e^n^d</pre>
