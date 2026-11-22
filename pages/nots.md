# NOTS

NOTS function is used to return a dynamic array of the logical
complements of each element of dynamic.array.

## COMMAND SYNTAX

    NOTS(dynamic.array)

If the value of the element is true, the NOTS function returns a
false value (0) in the corresponding element of the returned array.
If the value of the element is false, the NOTS function returns a
true value (1) in the corresponding element of the returned array.

A numeric expression that evaluates to 0 has a logical value of false.
A numeric expression that evaluates to anything else, other than the
null value, is a logical true.

An empty string is logically false. All other string expressions,
including strings, which consist of an empty string, spaces, or the
number 0 and spaces, are logically true.

If any element in dynamic.array is null, it returns null for that
element.

## EXAMPLE

       X = 5  ; Y = 5
       PRINT OCONV( NOTS(X-Y :@VM: X+Y), 'MCP' )     ;*  1]0
