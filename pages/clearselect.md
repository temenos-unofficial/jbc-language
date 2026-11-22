# CLEARSELECT

Use the CLEARSELECT statement to clear active select lists.

## COMMAND SYNTAX

    CLEARSELECT { ListName | ListNumber }

## SYNTAX ELEMENTS

ListName must evaluate to a jBC list variable. ListNumber is one of the
numbered lists in the range 0 to 11. If neither ListName nor ListNumber
are specified then it clears the default list (0).

## EXAMPLE

    A = "good" : @AM : "bad" : @AM : "ugly"
    B = "night" : @AM : "day"
    SELECT A TO 3
    SELECT B TO blist
    adone = 0 ; bdone = 0
    //
    LOOP
     READNEXT Ael FROM 3 ELSE adone = 1
       READNEXT Bel FROM blist ELSE bdone = 1
    UNTIL adone AND bdone DO
       CRT Ael, Bel
       CLEARSELECT 3
       CLEARSELECT blist
    REPEAT

This program displays:

<pre>
    good night</pre>
