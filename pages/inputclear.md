# INPUTCLEAR

The INPUTCLEAR statement clears the type-ahead buffer.

## COMMAND SYNTAX

    INPUTCLEAR

## SYNTAX ELEMENTS

None

## NOTES

INPUTCLEAR only clears the type-ahead buffer. It does not clear data
stacked with the DATA statement.

The INPUTCLEAR statement is synonymous with [CLEARINPUT](https://jbc-lang.org/pages/clearinput.md).

## EXAMPLE

    CRT "Start year end processing (Yes/No) :"
    INPUTCLEAR
    INPUT ans
    IF ans # "Yes" THEN
    CRT "year end processing not started"
    END
