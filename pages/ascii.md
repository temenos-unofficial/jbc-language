# ASCII

The ASCII function converts all the characters in the expression from
the EBCDIC character set to the ASCII character set.

## COMMAND SYNTAX

    ASCII(expression)

## SYNTAX ELEMENTS

The expression may return a data string of any form. The function will
then assume that the characters are all members of the EBCDIC character
set and translate them using a character map. The original expression
is unchanged while the returned result of the function is now the ASCII
equivalent.

## EXAMPLE

Create the file test.txt in hex editor containing the following characters (in hex):

<pre>
    C8 85 93 93 96 40 91 C2 C3</pre>

Run the following program:

       OSREAD the_line FROM 'test.txt' ELSE NULL
       CRT ASCII(the_line)

Output:

<pre>
    Hello jBC</pre>
