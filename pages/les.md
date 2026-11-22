# LES

LES function is used to determine whether elements of one dynamic
array are less than or equal to the elements of another dynamic
array.

## COMMAND SYNTAX

    LES(array1, array2)

It compares each element of array1 with the corresponding element
of array2. If the element from array1 is less than or equal to the
element from array2,  1 is returned in the corresponding element of
a new dynamic array. If the element from array1 is greater than the
element from array2, it returns zero (0). If an element of one dynamic
array has no corresponding element in the other dynamic array, it
evaluates the undefined element as empty, and the comparison continues.

If either of a corresponding pair of elements is null, it returns null
for that element. If you use the subroutine syntax, it returns the
resulting dynamic array as return.array.
