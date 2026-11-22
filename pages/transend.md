# TRANSEND

TRANSEND statement is used to mark the end of a successfully
completed transaction.

## COMMAND SYNTAX

    TRANSEND {end-text} [ THEN statement | ELSE statement ]

## SYNTAX ELEMENTS

**end-text** specifies an optional text string to save with the
transaction end record.

A **THEN** or **ELSE** (or both) statement is required. The THEN clause
will be executed if the transaction is successfully ended. The ELSE
clause will be executed if the transaction end fails for any reason.

## NOTES

Any record locks set during the transaction will be released upon
successful completion.
