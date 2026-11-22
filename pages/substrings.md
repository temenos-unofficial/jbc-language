# SUBSTRINGS

SUBSTRINGS function returns a dynamic array of elements, which are
sub-strings of the corresponding elements in a supplied dynamic array.

## COMMAND SYNTAX

    SUBSTRINGS(DynArr, Start, Length)

## SYNTAX ELEMENTS

**DynArr** should evaluate to a dynamic array.

**Start** specifies the position from which characters are extracted
from each array element. It should evaluate to an integer greater than
zero.

**Length** specifies the number of characters to extract from each
dynamic array element. If the length specified exceeds the number of
characters remaining in an array element then all characters from
the Start position are extracted.

## INTERNATIONAL MODE

When using the SUBSTRINGS function in International Mode, the function
will use the 'start' and 'length' parameters to the function as character
count values, rather than bytecount

## EXAMPLES

The following program shows how each element of a dynamic array can be
changed with the FIELDS function.

    t = ""
    t<1> = "AAAAA"
    t<2> = "BBBBB" :@VM: "CCCCC" : @SM: "DDDDD"
    t<3> = "EEEEE" :@VM: @SM
    r1 = SUBSTRINGS(t,3,2)
    r2 = SUBSTRINGS(t,4,20)
    r3 = SUBSTRINGS(t,0,1)

The above program creates 3 dynamic arrays. v represents a value mark.
s represents a sub-value mark.

| Array    |  Contents          |
|----------|--------------------|
|r1        |  <1>AA             |
|          |  <2>BB v CC s DD   |
|          |                    |
|          |  <3>EE v s         |
|          |                    |
| r2       |  <1>AA             |
|          |                    |
|          |  <#>BB v CC s      |
|          |                    |
|          |  <3>EE v s         |
|          |                    |
| r3       |  <1>A              |
|          |                    |
|          |  <2>B v C s D      |
|          |                    |
|          |  <3>E v s          |
