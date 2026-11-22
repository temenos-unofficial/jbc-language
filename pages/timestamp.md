# TIMESTAMP

TIMESTAMP returns a UTC timestamp value as decimal seconds.

## COMMAND SYNTAX

    TIMESTAMP()

## SYNTAX ELEMENTS

The TIMESTAMP function returns a Universal Coordinated Time (UTC)
value as decimal seconds, i.e. Seconds with tenths and hundredths
specified after the decimal point.

"The value is returned as a variable with as many decimal places as
the current precision allows. However, successive calls may return
the same value many times before the operating system updates the
underlying timer. For example, Windows updates the low level timer
every 1/50 second even though it stores the time in billionths
of a second."

## EXAMPLE

       V.TS = TIMESTAMP()
       CRT V.TS                     ;* e.g. 1352316687.1156
       CRT ( MAKETIMESTAMP( DATE(), TIME(), 'Europe/Amsterdam') - V.TS ) / 3600 ;* -1
       CRT ( MAKETIMESTAMP( DATE(), TIME(), 'Asia/Singapore') - V.TS ) / 3600   ;* -8
