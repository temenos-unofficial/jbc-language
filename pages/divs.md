# DIVS

Use the DIVS function to create a dynamic array containing the result
of the element-by-element division of two dynamic arrays.

## COMMAND SYNTAX

    DIVS(array1, array2)

The division of each element of array1 is by the corresponding element
of array2, which returns the result in the corresponding element of a
new dynamic array. If elements of array1 have no corresponding elements
in array2, it pads array2 with ones and returns the array1 elements. If
an element of array2 has no corresponding element in array1, it returns
zero. If an element of array2 is zero, it prints a run-time error message
and returns 0. If either element of a corresponding pair is null, it
returns null.

## EXAMPLE

    A=10:@VM:15:@VM:9:@SM:4
    B=2:@VM:5:@VM:9:@VM:2
    PRINT DIVS(A,B)

The output of this program is: 5]3]1\4]0.
