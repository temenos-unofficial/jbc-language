# WRITET

WRITET statement enables data to be written to a range of tape
devices between 0-9.

## COMMAND SYNTAX

    WRITET variable { ON | TO expression } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable** is the variable that holds the data for writing to
the tape device.

**expression** should evaluate to an integer value in the range
0-9 and specifies from which tape channel to read the data. If
the ON clause is not specified the WRITET will assume channel 0.

If the WRITET fails then the statements associated with any ELSE
clause will be executed. SYSTEM(0) will return the reason for
the failure as follows:

| Code | Description                                |
|------|--------------------------------------------|
|1     | There is no media attached to the channel. |
|2     | End of media found.                        |

## NOTES

A "tape" does not refer to magnetic tape devices only but any
device that has been described to TAFC. Writing device descriptors
for TAFC is beyond the scope of this documentation.

If no tape device has been assigned to the specified channel the
TAFC debugger is entered with an appropriate message.

Where possible the record size is not limited to a single tape
block and the entire record will be written blocked to whatever
block size has been allocated by the T-ATT command. However,
certain devices do not allow TAFC to accomplish this (SCSI
tape devices for instance).

## EXAMPLE

    LOOP
       WRITET TapeRec ON 5 ELSE
          Reason = SYSTEM(0)
          IF Reason = 2 THEN BREAK ;* done
          CRT "ERROR"  ;  STOP
       END
    REPEAT
