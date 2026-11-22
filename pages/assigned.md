# ASSIGNED

The ASSIGNED function is used to determine whether a variable has an
assigned value or not.

## COMMAND SYNTAX

    ASSIGNED(variable)

## SYNTAX ELEMENTS

ASSIGNED returns 1 if the variable has an assigned value
before the execution of this statement. If the variable has no
assigned value then the function returns 0.

See also: [UNASSIGNED](https://jbc-lang.org/pages/unassigned.md)

## EXAMPLE

       COMMON /MY.COMM/ V.VAR1
       CRT ASSIGNED(V.VAR1)   ;* always 1 if "named_common = zero"
                              ;* (e.g. for prime emulation)
       CRT V.VAR1             ;* 0 at the first run, YES at the second
       CRT ASSIGNED(V.VAR2)   ;* 0
       V.VAR1 = 'YES'
       V.VAR2 = 'NO'

## EXAMPLE 2

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP TYPE=MSSQL'
       OPEN 'F.TEMP' TO f_temp ELSE ABORT 201, 'F.TEMP'
       CRT ASSIGNED(f_temp)   ;* 1
       CLOSE f_temp
       CRT ASSIGNED(f_temp)   ;* 0

***TAFJ note: outputs 1 and 1 instead of 1 and 0.***
