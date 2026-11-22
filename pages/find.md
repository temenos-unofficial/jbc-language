# FIND

The FIND statement determines if a specified string fully matches to an
element in a dynamic array.

## COMMAND SYNTAX

    FIND expression1 IN Var1 {, expression2} SETTING Var2 {, Var3 {, Var4}} \
         THEN | ELSE statement(s)

## SYNTAX ELEMENTS

**expression1** evaluates to the string with which to compare every
element of the dynamic array. Var1 is the dynamic array that will be
searched. The FIND command will normally find the first occurrence of
expression1 unless **expression2** is specified. If specified then
expression2 will cause a specific occurrence of expression1 to be
located. The three variables **Var2, Var3, Var4** are used to record the
Field, Value and Sub-Value positions in which expression1 was found.

If expression1 is found in any element of Var1 then Vars 2, 3 and 4 are
set to the position in which it was found and any THEN clause of the
statement is executed. If expression1 is not found within any element
of the dynamic array then Vars 2, 3 and 4 are undefined and the ELSE
clause of the statement is executed.

## NOTES

The statement may omit either the THEN clause or the ELSE clause but
may not omit both. It is valid for the statement to contain both
clauses if required.

See also: [LOCATE](https://jbc-lang.org/pages/locate.md), [FINDSTR](https://jbc-lang.org/pages/findstr.md)

## EXAMPLE

       V.ARRAY = 'ABC'   \
           :@FM: 'DEF' :@VM: '123' :@VM: 'XYZ' :@VM: '456' \
           :@FM: '789' \
           :@FM: '---' : @SM: 'XYZ'
       GOSUB RESET.IT
       FIND 'XYZ' IN V.ARRAY SETTING V.FLD, V.VAL ELSE NULL
       CRT V.FLD, V.VAL            ;*   2       3
       GOSUB RESET.IT
       FIND 'XYYYZ' IN V.ARRAY SETTING V.FLD, V.VAL ELSE NULL
       CRT V.FLD, V.VAL            ;*   0       0
       GOSUB RESET.IT
       FIND 'XYZ' IN V.ARRAY, 2 SETTING V.FLD, V.VAL, V.SVAL ELSE NULL
       CRT V.FLD, V.VAL, V.SVAL    ;*   4       1       2
       GOSUB RESET.IT
    * Full match is required
       FIND 'XY' IN V.ARRAY SETTING V.FLD, V.VAL ELSE NULL
       CRT V.FLD, V.VAL            ;*   0       0
       GOSUB RESET.IT
       STOP
    RESET.IT:
       V.FLD = 0  ; V.VAL = 0  ;  V.SVAL = 0
       RETURN
