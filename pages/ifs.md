# IFS

Use the IFS function to return a dynamic array whose elements are
chosen individually from one of two dynamic arrays based on the
contents of a third dynamic array.

## COMMAND SYNTAX

    IFS(dynamic.array, true.array, false.array)

IFS evaluate each element of the **dynamic.array**. If the element
evaluates to true, it returns the corresponding element from
**true.array** to the same element of a new dynamic array. If the
element evaluates to false, it returns the corresponding element
from **false.array**. If there is no corresponding element in the
correct response array, it returns an empty string for that
element. If an element is null, that element evaluates to false.

***TAFJ R23 note: always returns "true" array:***

    CRT CONVERT(@FM:@VM:@SM, '^]\', IFS( 1 :@FM: 0 :@VM: 1 :@SM: 0 :@FM: 1,
             'This' :@FM: 'was' :@VM: 'how' :@SM: 'system' :@FM: 'works',
             'That' :@FM: 'is' :@VM: 'how' :@SM: 'Globus' :@FM: 'worked' ) )

    * TAFC: This^is]how\Globus^works
    * TAFJ: This^was]how\system^works
