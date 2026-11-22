# DATE

The DATE() function returns the date in internal system form. This
date is expressed as the number of days since December 31, 1967.

## COMMAND SYNTAX

    DATE()

## NOTES

The system and your own programs should manipulate date fields in
internal form. They can then be converted to a readable format of your
choice using the [OCONV](https://jbc-lang.org/pages/oconv.md) function and the date conversion
codes.

See also: [TIMEDATE](https://jbc-lang.org/pages/timedate.md)

## EXAMPLES

       curr_date = DATE()
       CRT curr_date                  ;* number of days (e.g. 16454) since day 1...
       CRT OCONV(1, 'D')              ;*  ...which is:  01 JAN 1968
       CRT OCONV(curr_date, 'D4/')    ;* e.g. 01/17/2013
