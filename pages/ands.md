# ANDS

Use the ANDS function to create a dynamic array of the logical AND of
corresponding elements of two dynamic arrays.

Each element of the new dynamic array is the logical AND of the
corresponding elements of array1 and array2. If an element of one
dynamic array has no corresponding element in the other dynamic array,
it returns a false (0) for that element.

If both corresponding elements of array1 and array2 are null, it returns
null for those elements. If one element is the null value and the other
is zero or an empty string, it returns false for those elements.

## COMMAND SYNTAX

    ANDS(array1, array2)

## EXAMPLE

        A = 1 :@SM: 4 :@VM: 4 :@SM: 1
        B = 1 :@SM: 1 - 1 :@VM: 2
        PRINT OCONV( ANDS(A, B), 'MCP' )    ;*  1\0]1\0

***TAFJ note: in the following example output is 1^1]0]1\ (trailing 0 is missing):***

       dyn_arr_one = 1 :@FM: 1 :@VM: 0 :@VM: 1 :@SM: 1
       dyn_arr_two = 1 :@FM: 1 :@VM: 1 :@VM: 1
       CRT ANDS(dyn_arr_one, dyn_arr_two)
