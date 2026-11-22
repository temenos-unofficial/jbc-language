# TIME

TIME() function returns the current system time.

## COMMAND SYNTAX

    TIME()

## NOTES

Returns the time as the number of seconds past midnight

## EXAMPLE

    CRT "Time is " : OCONV( TIME(), "MTS" )
