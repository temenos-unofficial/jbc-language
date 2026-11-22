# COUNTS

Use the COUNTS function to count the number of times a substring is
repeated in each element of a dynamic array. The result is a new
dynamic array whose elements are the counts corresponding to the
elements in the dynamic array.

## COMMAND SYNTAX

    COUNTS(dynamic.array, substring)

**dynamic.array** specifies the dynamic array whose elements are to
be searched.

**substring** is an expression that evaluates to the substring to be
counted. substring can be a character string, a constant, or a variable.
Each character in an element is matched to substring only once.
Therefore, when substring is longer than one character and a match is
found, the search continues with the character following the matched
substring. No part of the matched element is recounted toward another
match. If substring does not appear in an element, a 0 value is
returned. If substring is an empty string, the number of characters
in the element is returned. If substring is null, the COUNTS function
fails and the program terminates with a run-time error message. If any
element in dynamic.array is null, null is returned.

## EXAMPLE

    ARRAY= "A" :@VM: "AA" :@SM: "AAAAA"
    PRINT COUNTS(ARRAY, 'A')
    PRINT COUNTS(ARRAY, 'AA')

The output of this program is:

<pre>
    1]2\5
    0]1\2</pre>
