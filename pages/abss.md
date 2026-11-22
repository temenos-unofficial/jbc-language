# ABSS

Use the ABSS function to return the absolute values of all the elements
in a dynamic array. If an element in the dynamic array is null, it
returns null for that element.

## COMMAND SYNTAX

    ABSS(dynamic.array)

## EXAMPLE

       V.BEFORE = 500: @VM: 400: @VM: 300 :@SM: 200 :@SM: 100
       V.AFTER = SUBS(V.BEFORE, REUSE(300))     ;* decrease each element by 300
       CRT OCONV( ABSS(V.AFTER), 'MCP' )        ;*  200]100]0\100\200
