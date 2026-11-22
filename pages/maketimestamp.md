# MAKETIMESTAMP

MAKETIMESTAMP generates a timestamp using combination of internal date,
time and timezone.

## COMMAND SYNTAX

    MAKETIMESTAMP(InternalDate, InternalTime, TimeZone)

## SYNTAX ELEMENTS

The internal date and internal time values are combined together with the
time zone specification to return a UTC timestamp in decimal seconds.

## EXAMPLE

       CRT MAKETIMESTAMP( DATE(), TIME(), 'Europe/London')   ;* e.g. 1352113823.755
       CRT MAKETIMESTAMP( DATE(), TIME(), 'Europe/Belgrade') ;* e.g. 1352110223.755
