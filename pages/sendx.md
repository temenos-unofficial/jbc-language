# SENDX

SENDX statement sends a block of data (in hexidecimal) directly to a
device.

## COMMAND SYNTAX

    SENDX output {:} TO FileVar THEN | ELSE statements

## SYNTAX ELEMENTS

The output is an expression evaluating to a string that will be sent
to the output device (specified by FileVar).  It is expected that
[OPENSER](https://jbc-lang.org/pages/openser.md) or [OPENSEQ](https://jbc-lang.org/pages/openseq.md) has already opened the
device.

The SENDX statement will append a newline sequence to the final output
expression unless it is terminated with a colon ":" character.

## NOTES

As the expression can be any valid expression, it may have output
formatting applied to it.

The SENDX syntax requires a specified THEN or ELSE clause, or both.
If the data is send without error, it executes the THEN clause.
If the data cannot be sent, it executes the ELSE clause.

See also: [SEND](https://jbc-lang.org/pages/send.md)

## EXAMPLES

See: Sequential File Processing examples.
