# GOSUB

The GOSUB statement causes execution of a local subroutine, after which
execution will continue with the next line of code.

## COMMAND SYNTAX

    GOSUB label

## SYNTAX ELEMENTS

The label should refer to an existent label within the current source
code, which identifies the start of a local subroutine.

## EXAMPLE

       var_1 = 1  ; var_2 = 2  ; var_3 = 3
       GOSUB MAKE.ARRAY
       GOSUB OUTPUT                               ;* -1^-2^-3
       var_1 = -1  ; var_2 = -2 ; var_3 = -3
       GOSUB MAKE.ARRAY
       GOSUB OUTPUT                               ;* 1^2^3
       var_1 = 1  ; var_2 = -2 ; var_3 = 3
       GOSUB MAKE.ARRAY
       GOSUB OUTPUT                               ;* -1^2^-3
       STOP
    *------------------------Subroutines------------------------------------
    MAKE.ARRAY:
       dyn_array = NEGS(var_1 :@FM: var_2 :@FM: var_3)
       RETURN
    *------------
    OUTPUT:
       CRT FMT(dyn_array, 'MCP')
       RETURN

If you, for example, forget a RETURN in MAKE.ARRAY section the execution will
continue till the next RETURN, i.e. section OUTPUT will be executed 6 times
instead of 3.
