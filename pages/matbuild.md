# MATBUILD

This statement is used to create a dynamic array out of a dimensioned
array.

## COMMAND SYNTAX

    MATBUILD variable FROM array{, expression1{, expression2}} { USING expression3}

## SYNTAX ELEMENTS

**variable** is the jBC variable into which the created dynamic array
will be stored. Array is a previously dimensioned and assigned matrix
from which the dynamic array will be created.

**expression1** and **expression2** should evaluate to numeric integers.
expression1 specifies the array element from which the extraction
starts; expression2 specifies the array element on which the extraction
ends (inclusive).

By default, each array element is separated in the dynamic array by a
field mark. By specifying **expression3**, the separator character can
be changed. If expression3 evaluates to more than a single character,
only the first character of the string is used.

## NOTES

When specifying extraction starting and ending positions with
multi-dimensional arrays, it is necessary to expand the matrix into its
total number of variables for calculating the correct element number.
See the information about dimensioned arrays earlier in this chapter for
detailed instructions on calculating element numbers.

## EXAMPLE

       DIM A(40)
       MAT A = 'VALUE '
       FOR V.I = 1 TO 40
           A(V.I) := V.I
       NEXT V.I
       MATBUILD Dynamic FROM A, 3, 7 USING ":"
       CRT Dynamic               ;* VALUE 3:VALUE 4:VALUE 5:VALUE 6:VALUE 7

 Builds a 5 element string separated by ":" character.
 "MATBUILD Dynamic FROM A" builds a field mark separated dynamic array
from   every element contained in the matrix A.
