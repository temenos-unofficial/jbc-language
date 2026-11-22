# GES

Use the GES function to test if elements of one dynamic array are
greater than or equal to corresponding elements of another dynamic
array.

## COMMAND SYNTAX

    GES(array1, array2)

## SYNTAX ELEMENTS

Compares each element of array1 with the corresponding element of
array2, if the element from array1 is greater than or equal to the
element from array2, it returns a one in the corresponding element
of a new dynamic array. If the element from array1 is less than the
element from array2, it returns a zero (0). If an element of one
dynamic array has no corresponding element in the other dynamic array,
it evaluates the undefined element as empty, and the comparison
continues.

If either element of a corresponding pair is null, it returns null for
that element.
