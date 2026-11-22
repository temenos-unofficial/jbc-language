# TIMEDIFF

TIMEDIFF returns the interval between two timestamp values as a dynamic
array.

## COMMAND SYNTAX

    TIMEDIFF(Timestamp1, Timestamp2, Mask)

## SYNTAX ELEMENTS

The TIMEDIFF function returns the interval between two timestamp values
by subtracting the value of Timestamp2 from Timestamp1. The interval is
returned as an attribute delimited array of the time difference.

The Mask is an integer from 0 to 7 and selects one of the following
output formats:

|Mask    |         Array                                             |
|--------|-----------------------------------------------------------|
|0       | Days^Hours^Minutes^Seconds^Milliseconds (Default)         |
|1       | Weeks^Days^Hours^Minutes^Seconds^Milliseconds             |
|2       | Months^Days^Hours^Minutes^Seconds^Milliseconds            |
|3       | Months^Weeks^Days^Hours^Minutes^Seconds^Milliseconds      |
|4       | Years^Days^Hours^Minutes^Seconds^Milliseconds             |
|5       | Years^Weeks^Days^Hours^Minutes^Seconds^Milliseconds       |
|6       | Years^Months^Days^Hours^Minutes^Seconds^Milliseconds      |
|7       | Years^Months^Weeks^Days^Hours^Minutes^Seconds^Milliseconds|
