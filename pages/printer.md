# PRINTER

PRINTER statement controls the destination of output from the PRINT
statement.

## COMMAND SYNTAX

    PRINTER ON | OFF | CLOSE

## NOTES

**PRINTER ON** redirects all subsequent output from the PRINT statement
to the print spooler.

**PRINTER OFF** redirects all subsequent output from the PRINT statement
to the terminal device.

**PRINTER CLOSE** will act as PRINTER OFF but in addition closes the
currently active spool job created by the active PRINTER ON statement.

## EXAMPLES

        PRINTER ON             ;* Open a spool job
        FOR I = 1 TO 60
           PRINT "Line " : I   ;* Send to printer
           PRINTER OFF
           PRINT "+" :         ;* Send to terminal
           PRINTER ON          ;* Back to printer
        NEXT I
        PRINTER CLOSE          ;* Allow spooler to print it
