# LOCATE

LOCATE statement finds the position of an element within a specified
dimension of a dynamic array.

## COMMAND SYNTAX

    LOCATE expression1 IN expression2{<expression3{,expression4}>},{, expression5} \
           { BY expression6 } SETTING Var THEN | ELSE statement(s)

## SYNTAX ELEMENTS

**expression1** evaluates to the string that will be searched in
expression2.

**expression2** evaluates to the dynamic array within which
expression1 will search for the string.

**expression3** and **expression4** cause a value or subvalue
search respectively, when specified.

**expression5** indicates the field, value or subvalue from which the
search will begin.

**expression6** causes different searches to arrange the elements in
different order, which can considerably improve the performance of
some searches. The available string values for expression6 are:

|String|    Description                                      |
|------|-----------------------------------------------------|
|  AL  |Values are in ascending alphanumeric order           |
|  AR  |Values are in right justified, then ascending order  |
|  AN  |Values are in ascending numeric order                |
|  DL  |Values are in descending alphanumeric order          |
|  DR  |Values are in right justified, then descending order |
|  DN  |Values are in descending numeric order               |

Var will be set to the position of the Field, Value or Sub-Value in
which expression1 was found if indeed. If it was not found and
expression6 was not specified then Var will be set to one position
past the end of the searched dimension. If expression6 did specify
the order of the elements then Var will be set to the position before
which the element should be inserted to retain the specified order.

The statement must include one or both of the THEN and ELSE clauses.
If expression1 is found in an element of the dynamic array, then it
executes the statements defined by the THEN clause. If expression1
is not found in an element of the dynamic array, then it executes
the statements defined by the ELSE clause.

## INTERNATIONAL MODE

When the LOCATE statement is used in International Mode, the statement
will use the currently configured locale to determine the rules by
which each string is considered less than or greater than the other
will.

## NOTES

See also: [FIND](https://jbc-lang.org/pages/find.md), [FINDSTR](https://jbc-lang.org/pages/findstr.md)

## EXAMPLE

Using LOCATE to sort an array.

       V.ARR = ''
       FOR V.I = 1 TO 1000
          V.ARR<V.I> = RND(1000)
       NEXT V.I
       V.SORTED = ''
        FOR V.I = 1 TO 1000
          V.IN = V.ARR<V.I>
          LOCATE V.IN IN V.SORTED<1> BY 'AN' SETTING V.INS.POSN ELSE NULL
          INS V.IN BEFORE V.SORTED<V.INS.POSN>
       NEXT V.I
       CRT MINIMUM(V.ARR), MAXIMUM(V.ARR)  ;* e.g. "0       998"
       CRT V.SORTED<1>, V.SORTED<1000>     ;* numbers should be the same as above
