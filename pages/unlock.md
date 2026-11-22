# UNLOCK

UNLOCK statement releases a previously LOCKed execution lock.

## COMMAND SYNTAX

    UNLOCK {expression}

## SYNTAX ELEMENTS

**expression** should evaluate to the number of a held execution lock,
for release.

If omitting expression then it releases all execution locks held by
the current program.

## NOTES

There is no action if the program attempts to release an execution l
ock that it had not taken.

See also: [LOCK](https://jbc-lang.org/pages/lock.md)

## EXAMPLE

    LOCK 23 ; LOCK 32
    ......
    UNLOCK
