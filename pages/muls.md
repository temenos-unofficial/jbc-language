# MULS

MULS function is used to create a dynamic array of the element-by-element
multiplication of two dynamic arrays.

## COMMAND SYNTAX

    MULS(array1, array2)

Each element of **array1** is multiplied by the corresponding element
of **array2** with the result being returned in the corresponding element
of a new dynamic array. If an element of one dynamic array has no
corresponding element in the other dynamic array, 0 is returned. If
either of a corresponding pair of elements is null, null is returned
for that element.

## EXAMPLE

       A = 1 :@VM: 2 :@VM: 3 :@SM: 4
       B = 4 :@VM: 5 :@VM: 6 :@VM: 9
       PRINT OCONV( MULS(A, B), 'MCP' )       ;*  4]10]18\0]0
