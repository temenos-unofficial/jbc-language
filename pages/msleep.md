# MSLEEP

MSLEEP allows the program to pause execution for a specified number of
milliseconds.

## COMMAND SYNTAX

    MSLEEP {milliseconds}

## SYNTAX ELEMENTS

**milliseconds** must be an integer, which, specifies the number of
milliseconds to sleep.

When there are no parameters assumes a default time of 1 millisecond.

## NOTES

If a debugger is invoked and execution is continued while a program is
sleeping, then the user will be prompted:

Continue with SLEEP (Y/N) ?

If "N" is the response, the program will continue at the next statement
after the MSLEEP.

See also: [SLEEP](https://jbc-lang.org/pages/sleep.md) to sleep for a specified number of seconds or
until a specified time.

***TAFJ note: MSLEEP() function isn't supported***

## EXAMPLES

       CRT MAKETIMESTAMP( DATE(), TIME(), '' )           ;*  e.g. 1353068005.934
       MSLEEP(100)      ;* 0.1 sec
       CRT MAKETIMESTAMP( DATE(), TIME(), '' )           ;*  e.g. 1353068006.044
       MSLEEP(3000)      ;* 3 sec
       CRT MAKETIMESTAMP( DATE(), TIME(), '' )           ;*  e.g. 1353068009.039
       MSLEEP 3000       ;* this syntax also works
       CRT MAKETIMESTAMP( DATE(), TIME(), '' )           ;*  e.g. 1353068012.035
    * Sleep until the beginning of the next hour
       time = OCONV( TIME(), 'MT' )
       sleep_until = time[1, 2] + 1
       IF sleep_until EQ 24 THEN sleep_until = '00'
       sleep_until := ':00'
       CRT "I'll be back at " : sleep_until   ;*  e.g. I'll be back at 13:00
       SLEEP sleep_until
       CRT OCONV( TIME(), 'MTS' ), ',', "I'm back as promised"
