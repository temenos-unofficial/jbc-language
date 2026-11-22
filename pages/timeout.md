# TIMEOUT

If no data is read in the specified time, use the TIMEOUT statement to
terminate a [READSEQ](https://jbc-lang.org/pages/readseq.md) or [READBLK](https://jbc-lang.org/pages/readblk.md) statement.

## COMMAND SYNTAX

    TIMEOUT file.variable, time

## SYNTAX ELEMENTS

**file.variable** specifies a file opened for sequential access.

**time** is an expression that evaluates to the number of seconds the
program should wait before terminating the [READSEQ](https://jbc-lang.org/pages/readseq.md)
statement.

TIMEOUT causes subsequent READSEQ and READBLK statements to terminate
and execute ELSE statements if the number of seconds specified by
time elapses while waiting for data.

If either file.variable or time evaluates to null, the TIMEOUT
statement fails and the program enters the debugger.

## EXAMPLES

    TIMEOUT SLIPPERS, 10
    READBLK Var1 FROM SLIPPERS, 15 THEN PRINT Var1 ELSE
       PRINT "TIMEOUT OCCURRED"
    END
