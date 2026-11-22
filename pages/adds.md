# ADDS

Use ADDS function to create a dynamic array of the element-by-element addition
of two dynamic arrays. Added to each element of array1 is the
corresponding element of array2, which returns the result in the
corresponding element of a new dynamic array. If an element of one
array has no corresponding element in the other array, it returns the
existing element. If an element of one array is the null value, it
returns null for the sum of the corresponding elements.

## COMMAND SYNTAX

    ADDS(array1, array2)

## EXAMPLE

       Array1 = 2 :@VM: 4 :@VM: 6 :@SM: 10
       Array2 = 1 :@VM: 2: @VM: 3 :@VM: 4
       PRINT OCONV( ADDS(Array1, Array2), 'MCP' )   ;*  3]6]9\10]4
