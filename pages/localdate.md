# LOCALDATE

LOCALDATE returns an internal date using the specified Timestamp and
TimeZone combination.

## COMMAND SYNTAX

    LOCALDATE(Timestamp, TimeZone)

## SYNTAX ELEMENTS

The LOCALDATE function uses the specified timestamp and adjusts the
value by the specified time zone to return the date value in internal
date format.

## EXAMPLE

    start_time = MAKETIMESTAMP(DATE(), TIME(), '')
    time_shift = 100  ;  time_shift<8> = ''    ;* add 100 years to current date
    end_time = CHANGETIMESTAMP(start_time, time_shift)
    CRT OCONV(LOCALDATE(end_time, ''), 'D')               ;* e.g. 20 JUN 2113
