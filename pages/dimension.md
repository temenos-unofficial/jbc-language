# DIMENSION

Use the DIM statement to declare arrays to the compiler before
referencing.

## COMMAND SYNTAX

    DIM{ENSION} variable(number{, number... }){, variable(number {,number...}) ...}

## SYNTAX ELEMENTS

The **variable** may be any valid variable name neither declared nor
previously used. The numbers define the size of each dimension and must
be either constants or the subject of an EQUATE statement.
A single DIM statement may declare a number of arrays by separating
their declarations with a comma.

## NOTES

Declare the array before it is referenced in the program source
(compilation as opposed to execution). If using a variable as an
undeclared dimensioned array the compiler will display an error
message.

Do not use the array variable as a normal variable or dynamic array
before dimensioning, as the compiler will detect this as an error.

A dimension size may not be specified as one as this has no logical
meaning. The compiler will detect this as a warning.

When arrays are referenced directly as in A = Array(7), the compiler
will optimize the reference as if it was a single undimensioned
variable.

See also: [COMMON](https://jbc-lang.org/pages/common.md)

## EXAMPLES

       DIMENSION V.ARRAY(10)
       MAT V.ARRAY = '!'
       V.ARRAY(5) = '?'
       FOR V.I = 1 TO 10
          CRT V.ARRAY(V.I):          ;* !!!!?!!!!!
       NEXT V.I

       DIM V.DIM3(2, 3, 4)
       MAT V.DIM3 = 1
       V.DIM3(1,2,1) *= 2
       CRT ''
       CRT V.DIM3(1,2,1)             ;* 2
       CRT V.DIM3(1,2)               ;* still 2
       CRT V.DIM3(1,20,1)            ;* runtime error ARRAY_SUBS
