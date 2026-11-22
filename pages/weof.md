# WEOF

WEOF statement allows the program to write an EOF mark on an attached
tape device.

## COMMAND SYNTAX

    WEOF { ON expression }

## SYNTAX ELEMENTS

**expression** specifies the device channel to use. It should evaluate
to a numeric integer argument in the range 0-9, the default value is
zero.

## NOTES

If the WEOF fails it then executes the statements associated with
any ELSE clause. SYSTEM(0) will return the reason for the failure
as follows:

| Code | Description                                |
|------|--------------------------------------------|
|1     | There is no media attached to the channel. |
|2     | End of media found.                        |

A "tape" does not refer to magnetic tape devices only but to any
device described previously to TAFC.

If the specified channel has no assigned tape device, it enters the
TAFC debugger with an appropriate message.

## EXAMPLE

    WEOF ON 5 ELSE
        CRT "No tape device exists for channel 5"
    END
