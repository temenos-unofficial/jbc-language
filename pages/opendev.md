# OPENDEV

OPENDEV statement is used to open a device (or file) for sequential
writing and/or reading.

## COMMAND SYNTAX

    OPENDEV Device TO FileVar { LOCKED statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**Device** specifies the target device or file.

**FileVar** contains the file descriptor of the file when the open
was successful.

**Statements** are conditional jBC statements.

## NOTES

If the device does not exist or cannot be opened it executes the ELSE
clause. Once open it takes a lock on the device. If the lock cannot be
taken then the LOCKED clause is executed if it exists otherwise the
ELSE clause is executed. The specified device can be a regular file,
pipe or special device file. Regular file types only take locks. Once
open the file pointer is set to the first line of sequential data.

## EXAMPLE

    OPENDEV "\\.\TAPE0" TO tape.drive ELSE STOP

Opens the Windows default tape drive and prepares it for sequential
processing.

For more information on sequential processing, see [READSEQ](https://jbc-lang.org/pages/readseq.md),
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md) the sequential processing example.
