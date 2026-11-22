# GET

The GET statement reads a block of data directly from a device.

## COMMAND SYNTAX

    GET Var {,length} { SETTING Count } FROM Device { UNTIL TermChars } \
        { RETURNING TermChar }  { WAITING Timeout } THEN | ELSE statements

## SYNTAX ELEMENTS

**Var** is the variable in which to place the input (from the previously
open Device).

If length is specified, it limits the number of characters read from the
input device.

If the optional Count option is used, it returns the number of characters
actually read from the device.

Device is the file variable associated with the result from a successful
OPENSEQ or OPENSER command.

**TermChars** specifies one or more characters that will terminate input.

**TermChar** The actual character that terminated input

**Timeout** is the number of seconds to wait for input.  If no input is
present when the timeout period expires, the ELSE clause (if specified)
is executed.

## NOTES

The GET statement does no pre-or post-processing of the input data stream -
nor does it handle any terminal echo characteristics. If this is desired,
the application - or device drive - will handle it.
If there are no specified length and timeout expressions, the default input
length is one (1) character. If no length is specified, but TermChars are,
there is no limit to the number of characters input.
The GET syntax requires a specified THEN or ELSE clause, or both. The THEN
clause executes when the data received is error free; the ELSE clause
executes when the data is unreceiveable (or a timeout occurs).

See: [GETX](https://jbc-lang.org/pages/getx.md)
