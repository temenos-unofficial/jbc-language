# MATPARSE

MATPARSE statement is used to assign the elements of a matrix from the
elements of a dynamic array.

## COMMAND SYNTAX

    MATPARSE array{, expression1{, expression2}} FROM variable1  \
            { USING expression3} SETTING variable2

## SYNTAX ELEMENTS

**array** is a previously dimensioned matrix, which will be assigned
from each element of the dynamic array. variable1 is the jBC variable
from which the matrix array will be stored.

**expression1** and **expression2** should evaluate to numeric
integers. **expression1** specifies which element of the array the
assignment will start with; **expression2** specifies which element of
the array the assignment will end with (inclusive).

By default, the dynamic array assumes the use of a field mark to
separate each array element. By specifying **expression3**, the
separator character can be changed. If **expression3** evaluates to
more than a single character, only
the first character of the string is used.

As assignment will stop when the contents of the dynamic array
have been exhausted, it can be useful to determine the number of
matrix elements that were actually assigned to. If the SETTING
clause is specified then **variable2** will be set to the number of
elements of the array that were assigned to.

## NOTES

When specifying starting and ending positions with
multi-dimensional arrays, it is necessary to expand the matrix
into its total number of variables to calculate the correct
element number.

See the information about dimensioned arrays earlier in this
section for detailed instructions on calculating element numbers.

## EXAMPLES

       DIM dim_array(100)
       dyn_array = ''   ;     delim_array = ''
       FOR i = 1 TO 100
          dyn_array<-1> = i
          delim_array := i*2 : '-'
       NEXT i
    * Full copy
       MATPARSE dim_array FROM dyn_array
       CRT dim_array(1)                 ;* 1
       CRT dim_array(100)               ;* 100
    * Using different array delimiter
       MAT dim_array = 'Default'
       MATPARSE dim_array FROM delim_array USING '-'
       CRT dim_array(1)                 ;* 2
       CRT dim_array(100)               ;* 200
    * Partial copy
       MAT dim_array = 'Default'
       MATPARSE dim_array, 3, 7 FROM dyn_array
       CRT dim_array(1)                 ;* Default
       CRT dim_array(3)                 ;* 1
       CRT dim_array(5)                 ;* 3
       CRT dim_array(100)               ;* Default
    * "Over-copy"
       FOR i = 101 TO 103               ;* add 3 elements to dynamic array
          dyn_array<-1> = i
       NEXT i
       MAT dim_array = 'Default'
       MATPARSE dim_array FROM dyn_array
       CRT dim_array(1)                 ;* 1
       CRT dim_array(100)               ;* 100
       the_extra = dim_array(0)           ;* all excess elements are here
       CHANGE @FM TO '>>>' IN the_extra
       CRT the_extra                        ;* 101>>>102>>>103
    * 2-dimensioned array population: "left-to-right":
       DIM two_dim_array(100,2)
       MATPARSE two_dim_array FROM dyn_array
       CRT two_dim_array(1,1)                 ;* 1
       CRT two_dim_array(1,2)                 ;* 2
       CRT two_dim_array(2,1)                 ;* 3
       CRT two_dim_array(2,2)                 ;* 4
       CRT two_dim_array(50,2)                ;* 100
       CRT DQUOTE(two_dim_array(100,1))       ;* ""
