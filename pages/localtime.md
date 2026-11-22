# LOCALTIME

LOCALTIME returns an internal time using the specified Timestamp and
TimeZone combination.

## COMMAND SYNTAX

    LOCALTIME(Timestamp, TimeZone)

## SYNTAX ELEMENTS

The LOCALTIME function uses the specified timestamp and adjusts the
value by the specified time zone to return the time value in internal
time format.

Example that works correctly in TAFJ R23 and incorrectly in TAFC R23:

    a_date = ICONV( '20231031', 'DG' )
    a_time = ICONV( '12:34:56', 'MTS' )
    t_stamp = MAKETIMESTAMP( a_date, a_time, '' )
    time_array = 100 : @FM : @FM : @FM : @FM : @FM : @FM : @FM   ;* add 100 years
    future_ts = CHANGETIMESTAMP( t_stamp, time_array )
    future_date = OCONV( LOCALDATE( future_ts, '' ), 'D/E')
    future_time = OCONV( LOCALTIME( future_ts, '' ), 'MTS')
    CRT future_date, future_time

    * TAFC: 31/10/2123      03:14:08 - wrong
    * TAFJ: 31/10/2123      12:34:56 - correct
