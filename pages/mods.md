# MODS

MODS function is used to create a dynamic array of the remainder
after the integer division of corresponding elements of two dynamic
arrays.

## COMMAND SYNTAX

    MODS(array1, array2)

The MODS function calculates each element according to the following
formula:

<pre>
    XY.element = X ?? (INT(X / Y) * Y)</pre>

X is an element of array1 and Y is the corresponding element of array2.
The resulting element is returned in the corresponding element of a new
dynamic array. If an element of one dynamic array has no corresponding
element in the other dynamic array, 0 is returned. If an element of
array2 is 0, 0 is returned. If either of a corresponding pair of
elements is null, null is returned for that element.

## EXAMPLES

       A = 3 :@VM: 7
       B = 2: @SM: 7 :@VM: 4
       PRINT OCONV( MODS(A, B), 'MCP' )       ;*  1\0]3
