# LOCK

LOCK statement is used to set an execution lock thus preventing any
other jBC program to wait until this program has released it.

## COMMAND SYNTAX

    LOCK expression { THEN | ELSE statements}

## SYNTAX ELEMENTS

The expression should evaluate to a numeric value between 0 and 255
(63 in R83 import mode).

The statement will execute the THEN clause (if defined) providing
the lock could be taken. If another program holds the LOCK and an
ELSE clause is provided then the statements defined by the ELSE
clause are executed. If no ELSE clause was provided with the
statement then it will block (hang) until the other program has
released the lock.

## NOTES

See also: [UNLOCK](https://jbc-lang.org/pages/unlock.md)

If you use the environment variable JBCEMULATE set to r83, to compile
the program the number of execution locks is limited to 64. If an
execution lock greater than this number is specified, then the actual
lock taken is the specified number modulo 64.

## EXAMPLES

    LOCK 32 ELSE
        CRT "This program is already executing!"
    STOP
    END
