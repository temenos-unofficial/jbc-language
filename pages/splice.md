# SPLICE

SPLICE function is used to create a dynamic array of the
element-by-element concatenation of two dynamic arrays, separating
concatenated elements by the value of expression.

## COMMAND SYNTAX

    SPLICE(array1, expression, array2)

## SYNTAX ELEMENTS

Each element of array1 is concatenated with expression and with the
corresponding element of array2. The result is returned in the
corresponding element of a new dynamic array. If an element of one
dynamic array has no corresponding element in the other dynamic
array, the element is returned properly concatenated with expression.
If either element of a corresponding pair is null, null is returned
for that element. If expression evaluates to null, null is returned
for the entire dynamic array.

## EXAMPLE

    A = "A" :@VM: "B" :@SM: "C"
    B = "D" :@SM: "E" :@VM: "F"
    C = '-'
    PRINT SPLICE(A,C,B)

The output of this program is:

<pre>
    A-D\-E]B-F\C-</pre>
