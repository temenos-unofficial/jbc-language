# CHANGETIMESTAMP

Use CHANGETIMESTAMP to adjust existing timestamp to return new
timestamp value.

## COMMAND SYNTAX

    CHANGETIMESTAMP(Timestamp, Array)

## SYNTAX ELEMENTS

The CHANGETIMESTAMP function generates a new timestamp by adjusting
an existing timestamp value using the elements specified in the
dynamic array.

The format of the adjustment array is as follows:

<pre>
    Years^Months^Weeks^Days^Hours^Minutes^Seconds^Milliseconds</pre>

## EXAMPLE

       curr_time = MAKETIMESTAMP(DATE(), TIME(), '')
       CRT curr_time                                    ;*   e.g. 1358247401.205
    * Years^Months^Weeks^Days^Hours^Minutes^Seconds^Milliseconds
    * Add 100 milliseconds
       adj_array = ''
       adj_array<8> = 100
       CRT CHANGETIMESTAMP(curr_time, adj_array) ;* 1358247401.305 for example above
       adj_array<8> = ''
       adj_array<1> = 100   ;* 100 years
       CRT CHANGETIMESTAMP(curr_time, adj_array)   ;* 4513921001.205
