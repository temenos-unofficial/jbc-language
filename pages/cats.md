# CATS

The CATS function concatenates the corresponding elements in two dynamic
arrays.

## COMMAND SYNTAX

    CATS(DynArr1, DynArr2)

## SYNTAX ELEMENTS

DynArr1 and DynArr2 represent dynamic arrays.

## NOTES

If one dynamic array supplied to the CATS function is null then the result
of the CATS function is the non-null dynamic array.

## EXAMPLES

    * Same array structure -------------
       an_array =   "a" : @VM : "b" : @VM : "c"
       another_array = 1 : @VM : 2 : @VM : 3
       GOSUB DO.PROCEED                                     ;*   a1]b2]c3
    * Different array structure -------------
       an_array =      "a" : @SM : "b" : @VM : "c" : @VM : "d"
       another_array = "x" : @VM : "y" : @SM : "z"
       GOSUB DO.PROCEED                                     ;*   ax\b]cy\z]d
       STOP
    *-------------
    DO.PROCEED:
       the_result = CATS(an_array, another_array)
       CRT OCONV(the_result, 'MCP')
       RETURN
