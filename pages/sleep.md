# SLEEP

SLEEP function allows the program to pause execution for a specified
period.

## COMMAND SYNTAX

    SLEEP {expression}

## SYNTAX ELEMENTS

**expression** may evaluate to one of two forms:

Numeric in which case the statement will sleep for the specified number
of seconds or fractions of a second

"nn:nn{:nn}" in which case the statement will sleep until the time
specified.

If expression is not supplied then a default period of 1 second is
assumed.

## NOTES

Sleeping until a specified time works by calculating the time between
the current time and the time supplied and sleeping for that many
seconds. If in the meantime the host clock is changed the program
will not wake up at the desired time;

***TAFJ note: sleeping until a specified time doesn't work.***

If invoking the debugger while a program is sleeping and the execution
continued, the user will be prompted:

<pre>
    Continue with SLEEP (Y/N)?</pre>

If "N" is the response, the program will continue at the next statement
after the SLEEP.

See also: MSLEEP to sleep for a specified number of milliseconds.

## EXAMPLES

Sleep until the end of the working day for anyone who doesn't program
computers:

    SLEEP "17:30"
    * 40 winks...
    SLEEP 40
    * Sleep for two and a half seconds...
    SLEEP 2.5
