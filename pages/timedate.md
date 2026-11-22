# TIMEDATE

TIMEDATE() function returns the current time and date as a printable
string.

## COMMAND SYNTAX

    TIMEDATE()

## NOTES

The function returns a string of the form: hh:mm:ss dd mmm yyyy or
in the appropriate format for your international date setting.

## EXAMPLES

    CRT "The time and date is " : TIMEDATE()
