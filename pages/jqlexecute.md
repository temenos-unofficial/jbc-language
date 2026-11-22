# JQLEXECUTE

JQLEXECUTE starts executing a compiled jQL statement.

## COMMAND SYNTAX

    JQLEXECUTE(Statement, SelectVar)

## SYNTAX ELEMENTS

**Statement** is the valid result of a call to a
JQLCOMPILE (Statement, ...)

**SelectVar** is a valid select list used to limit the statement to a
predefined set of items. For example - how it's used in jQL (note the "&gt;") prompt:

<pre>
    SELECT PROGRAMMERS WITH IQ_IN_PTS > 250
    &nbsp;
    1 Item Selected
    &nbsp;
    > LIST PROGRAMMERS NAME
    &nbsp;
    PROGRAMMERS...    NAME
    &nbsp;
    0123              COOPER, F B</pre>

This function returns -1 in the event of a problem, such as an
incorrect statement variable. It will cause the statement to run
against the database and produce a result set for use with JQLFETCH().
