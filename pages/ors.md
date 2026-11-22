# ORS

ORS function is used to create a dynamic array of the logical OR of
corresponding elements of two dynamic arrays.

## COMMAND SYNTAX

    ORS(array1, array2)

Each element of the new dynamic array is the logical OR of the
corresponding elements of **array1** and **array2**. If an element
of one dynamic array has no corresponding element in the other
dynamic array, it assumes a false for the missing element.

If both corresponding elements of array1 and array2 are null, it
returns null for those elements. If one element is the null value
and the other is 0 or an empty string, it returns null. If one
element is the null value and the other is any value other than 0
or an empty string, it returns true.

## EXAMPLE

       A = "A" :@SM: 0 :@VM: 4 :@SM: 1
       B = 0 :@SM: 1-1 :@VM :2
       PRINT OCONV( ORS(A, B), 'MCP')         ;*   1\0]1\1
