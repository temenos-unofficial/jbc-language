# SEND

SEND statement sends a block of data directly to a device.

## COMMAND SYNTAX

    SEND output {:} TO FileVar THEN | ELSE statements

## SYNTAX ELEMENTS

The output is an expression evaluating to a string that will be sent
to the output device (specified by FileVar).  It is expected that
the device has already been opened with [OPENSER](https://jbc-lang.org/pages/openser.md) or
[OPENSEQ](https://jbc-lang.org/pages/openseq.md).

The SEND statement will append a newline sequence to the final
output expression unless it is terminated with a colon ":" character.

## NOTES

As the expression can be any valid expression, it may have output
formatting applied to it.

The SEND syntax requires you specify either a THEN or ELSE clause,
or both.  It executes the THEN clause if the data is without error.
Else executes, the ELSE clause if the data cannot be sent.

See also: [SENDX](https://jbc-lang.org/pages/sendx.md)

## EXAMPLES

See also: Sequential File Processing.
