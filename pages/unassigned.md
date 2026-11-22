# UNASSIGNED

UNASSIGNED function allows a program to determine whether a variable
has been assigned a value.

## COMMAND SYNTAX

    UNASSIGNED(variable)

## SYNTAX ELEMENTS

**variable** is the name of variable used elsewhere in the program.

## NOTES

The function returns Boolean TRUE if variable has not yet been
assigned a value. The function returns Boolean FALSE if variable
has already been assigned a value.

See also: [ASSIGNED](https://jbc-lang.org/pages/assigned.md)

## EXAMPLES

       OPEN 'F.TEMP' TO F.TEMP ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       END
       CRT UNASSIGNED(F.TEMP)        ;* 0
       CLOSE F.TEMP
       CRT UNASSIGNED(F.TEMP)        ;* 1 under TAFC, 0 under TAFJ
       CRT UNASSIGNED(V.VAR)         ;* 1
       V.VAR = 5
       CRT UNASSIGNED(V.VAR)         ;* 0
       CLEAR
       CRT UNASSIGNED(V.VAR)         ;* 0 - it was assigned the value 0
