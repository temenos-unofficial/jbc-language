# TRANSQUERY

TRANSQUERY function is used to detect whether or not a transaction is
active on the current process.

## COMMAND SYNTAX

    TRANSQUERY()

## NOTES

TRANSQUERY will return 1 (true) if the process is within a transaction
boundary, and 0 (false) if it is not. In other words, TRANSQUERY will
return true if the [TRANSTART](https://jbc-lang.org/pages/transtart.md) statement has been issued
but a [TRANSEND](https://jbc-lang.org/pages/transend.md) or [TRANSABORT](https://jbc-lang.org/pages/transabort.md) statement has
not yet been processed.

By default, all hashed files are marked for inclusion in a transaction
however this can be modified by the jchmod utility.
