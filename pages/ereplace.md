# EREPLACE

Use the EREPLACE function to replace substring in an expression with
another substring. If you do not specify an occurrence, it replaces
each occurrence of a substring.

## COMMAND SYNTAX

    EREPLACE(expression, substring, replacement [,occurrence [,begin] ] )

## SYNTAX ELEMENTS

**occurrence** specifies the number of occurrences of substring to
replace. To replace all occurrences, specify occurrence as a number
less than 1. **begin** specifies the first occurrence to replace. If
begin is omitted or less than one, it defaults to one. If
**substring** is an empty string, replacement is prefixed to
expression. If replacement is an empty string, it removes all
occurrences of substring. If **expression** evaluates to null, it
returns null. If substring, replacement, occurrence, or begin evaluates
to null, the EREPLACE function fails and the program terminates with a
run-time error message. The EREPLACE function behaves like the CHANGE
function except when substring evaluates to an empty string.

## EXAMPLE

    A = "AAABBBCCCDDDBBB"
    PRINT EREPLACE(A,'BBB', 'ZZZ')
    PRINT EREPLACE(A, '', 'ZZZ')
    PRINT EREPLACE(A, 'BBB', '')

The output of this program is:

<pre>
    AAAZZZCCCDDDZZZ
    AAABBBCCCDDDBBB - under TAFC R23 (incorrect)
    ZZZAAABBBCCCDDDBBB - under TAFJ R23 (correct)
    AAACCCDDD</pre>
