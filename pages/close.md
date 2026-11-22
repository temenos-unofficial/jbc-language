# CLOSE

Use the CLOSE statement to CLOSE an opened file, which is no longer
required.

## COMMAND SYNTAX

    CLOSE variable {, variable ... }

## SYNTAX ELEMENTS

The variable list should contain a list of previously opened file
variables that are no longer needed. The variables will be cleared
and may be reused as ordinary variables.

## NOTES

You can open an unlimited amount of files within jBC;
however leaving them open consumes valuable system resources.

Use good practice to hold open only those file descriptors to
which you have constant access.

## EXAMPLE

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       CRT ASSIGNED(F.TEMP)        ;* 1
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       CLOSE F.TEMP
       CRT ASSIGNED(F.TEMP)        ;* 0
