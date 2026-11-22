# OUT

OUT statement is used to send raw characters to the current output
device (normally the terminal).

## COMMAND SYNTAX

    OUT expression

## SYNTAX ELEMENTS

**expression** should evaluate to a numeric integer in the range 0
to 255, being the entire range of ASCII characters.

## NOTES

The numeric expression is first converted to the raw ASCII character
specified and then sent directly to the output advice.

## EXAMPLES

    EQUATE BELL TO OUT 7
    BELL ;* Sound terminal bell
    FOR I = 32 TO 127 ; OUT I ; NEXT I ;* Printable chars
    BELL
