# CONVERT (STATEMENT)

The CONVERT statement converts one or more characters in a string to
their corresponding replacement characters.

## COMMAND SYNTAX

    CONVERT expression1 TO expression2 IN expression3

## SYNTAX ELEMENTS

**expression1** is the list of all characters to translate in
expression3

**expression2** is the list of characters that will be converted to.

**expression3** is the string to which the conversion will apply.

## NOTES

There is a one to one correspondence between the characters in
expression1 and expression2. That is, conversion of character 1 in
expression1 to character 1 in expression2, etc.

See also: [CONVERT](https://jbc-lang.org/pages/convert.md)

## EXAMPLE

    Value = 'ABCDEFGHIJ'
    CRT 'Original:   ':Value
    CONVERT 'BJE' TO '^+!' IN Value
    CRT 'Converted: ':Value

Output:

<pre>
    Original:   ABCDEFGHIJ
    Converted: A^CD!FGHI+</pre>
