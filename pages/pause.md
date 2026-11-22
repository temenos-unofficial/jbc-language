# PAUSE

PAUSE statement allows processing to be suspended until an external
event triggered by a [WAKE](https://jbc-lang.org/pages/wake.md) statement from another process or
a timeout occurs.

## COMMAND SYNTAX

    PAUSE {expression}

## SYNTAX ELEMENTS

**expression** may evaluate to a timeout value, which is the maximum
number of seconds to suspend the process. If the expression is omitted
then the PAUSE statement will cause the process to suspend until woken
by the [WAKE](https://jbc-lang.org/pages/wake.md) statement.

If a timeout value is specified and the suspended process is not woken
by the [WAKE](https://jbc-lang.org/pages/wake.md) statement then the process will continue once the
timeout period has expired.

If a [WAKE](https://jbc-lang.org/pages/wake.md) statement is executed before a PAUSE statement, then
the PAUSE will be ignored and processing will continue until a subsequent
PAUSE statement.

## EXAMPLE

Pausing program:

       @USER.ROOT = 'Sleeping beauty'
       start_time = TIME()
       CRT 'Pausing...'
       PAUSE 20
       IF TIME() - start_time LT 20 THEN CRT "Who's there?"
       ELSE CRT 'Resuming...'

Waking program:

    INCLUDE JBC.h
       OPEN SYSTEM(1027) TO PROC ELSE STOP 201, SYSTEM(1027)
       SELECT PROC
       *
       LOOP WHILE READNEXT key DO
          READ rec FROM PROC, key THEN
             IF rec<USER_PROC_USER_ROOT> EQ 'Sleeping beauty' THEN
                CRT 'Found...' :
                WAKE rec<USER_PROC_PORT_NUMBER>
                CRT 'and awoken'
                STOP
             END
          END
       REPEAT
       CRT 'Nobody sleeps'
