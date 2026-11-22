# RELEASE

RELEASE statement enables a program to explicitly release record locks
without updating the records using [WRITE](https://jbc-lang.org/pages/write.md).

## COMMAND SYNTAX

    RELEASE {{variable,} expression}

## SYNTAX ELEMENTS

If variable is specified it should be a valid file descriptor variable
(i.e. It should have been the subject of an [OPEN](https://jbc-lang.org/pages/open.md) statement)

If an expression is supplied it should evaluate to the record key of a
record whose lock the program wishes to free. If variable was specified
the record lock in the file described by it is released. If variable was
not specified the record lock in it releases the file described by the
default file variable

If RELEASE is issued without arguments then all record locks in all files
that were set by the current program will be released.

## NOTES

Where possible the program should avoid the use of RELEASE without
arguments; this is less efficient and can be dangerous - especially
in subroutines.

## EXAMPLE

This program optionally creates file F.TEMP and writes to it a record REC1, on the following
runs it updates that record - puts a new field in it, but only if theres less than 7 fields:

       OPEN 'F.TEMP' TO F.TEMP ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE
             CRT 'OPEN FAILED'
             STOP
          END
       END
       READU V.REC FROM F.TEMP, 'REC1' LOCKED
          CRT 'Record locked (' : RECORDLOCKED(F.TEMP, 'REC1') : ')'
          STOP
       END ELSE NULL
       IF DCOUNT(V.REC, @FM) GT 5 THEN RELEASE F.TEMP, 'REC1'
       ELSE
          V.REC<-1> = 'A field'
          WRITE V.REC TO F.TEMP, 'REC1'
       END
