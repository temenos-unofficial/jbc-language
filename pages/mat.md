# MAT

This command is used to assign a single value for every element in a
specified array or to assign the entire contents of one array to another.

## COMMAND SYNTAX

    MAT Array = expression

    MAT Array1 = MAT Array2

## SYNTAX ELEMENTS

**Array**, **Array1** and **Array2** are all pre-dimensioned arrays
declared with the DIM statement. **expression** can evaluate to any
data type.

## NOTES

If any element of the array Array2 has not been assigned a value then a
runtime error message will occur. This can be avoided by coding the
statement MAT Array2 = " after the DIM statement.

## EXAMPLE

       DIM A(45), G(45)
       MAT G = "Array value"
       MAT A = MAT G
       CRT DQUOTE(A(45))                    ;* "Array value"
