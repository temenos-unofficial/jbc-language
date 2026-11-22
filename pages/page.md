# PAGE

PAGE command is used to print any FOOTING statement, throw a PAGE and
print any heading statement on the current output device.

## COMMAND SYNTAX

    PAGE {expression}

## SYNTAX ELEMENTS

If **expression** is specified it should evaluate to a numeric integer,
which will cause the page number after the page throw to be set to this
value.

## EXAMPLES

    HEADING '10 PAGE REPORT'
    FOR I = 1 TO 10
    	    PAGE
    	    GOSUB PrintPage
    NEXT I
