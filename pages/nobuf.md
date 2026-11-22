# NOBUF

NOBUF statement turns off buffering for a file previously opened for
sequential processing.

## COMMAND SYNTAX

    NOBUF file.variable { THEN statements [ ELSE statements ] | ELSE statements }

## DESCRIPTION

jBASE can buffer for sequential input and output operations. The NOBUF
statement turns off this behavior and causes all writes to the file to
be performed immediately. The NOBUF statement should be used in
conjunction with a successful OPENSEQ statement and before any input
or output is performed on the record.

If the NOBUF operation is successful, it executes the THEN statements
otherwise, executes the ELSE statements. If file.variable is not a
valid file descriptor then NOBUF statement fails and the program
enters the debugger.

## EXAMPLE

In the following example, if RECORD in DIRFILE can be opened,
output buffering is turned off:

    OPENSEQ 'DIRFILE', 'RECORD' TO FILE THEN NOBUF FILE
    ELSE ABORT
