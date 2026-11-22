# JBASESubroutineExist

Check if a subroutine exists in current environment:

## COMMAND SYNTAX

    CALLC JBASESubroutineExist(SubName, SubInfo)

where **SubName** is subroutine name; returns 1 or 0.
**SubInfo** is reserved for future use.

## EXAMPLE

       SubName = 'CDD'
       Result = CALLC JBASESubroutineExist(SubName, SubInfo)
       CRT Result                 ;* 1 in T24 TAFC environment, 0.0 under TAFJ
       CRT SQUOTE(SubInfo)        ;* '' under TAFC, 'Subroutine' under TAFJ
       SubName = 'QWERTY'
       Result = CALLC JBASESubroutineExist(SubName, SubInfo)
       CRT Result            ;* 0
