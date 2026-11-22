# EQS

Use the EQS function to test if elements of one dynamic array are equal
to the elements of another dynamic array.

## COMMAND SYNTAX

    EQS(array1, array2)

EQS compares each element of array1 with the corresponding element
of array2 and returns, a one if the two elements are equal in the
corresponding element of a dynamic array. It returns a zero if the two
elements are not equal. It returns zero if an element of one dynamic
array has no corresponding element in the other dynamic array. If either
element of a corresponding pair is null, it returns null for that
element.

## EXAMPLE

    A=1:@VM:45:@SM:3:@VM:'one'
    B=0:@VM:45:@VM:1
    PRINT EQS(A,B)

The output of this program is: 0]1\0]0
