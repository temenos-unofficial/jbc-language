# FILEUNLOCK

Use the FILEUNLOCK statement to release a file lock set by the
FILELOCK statement.

## COMMAND SYNTAX

    FILEUNLOCK [file.variable] [ ON ERROR statements ]

**file.variable** specifies a file previously locked with a
FILELOCK statement. If file.variable is not specified, the default
file with the FILELOCK statement is assumed .If file.variable is
not a valid file variable then the FILEUNLOCK statement will enter
the debugger.

*The ON ERROR Clause*

The ON ERROR clause is optional in the FILELOCK statement. The ON
ERROR clause lets you specify an alternative for program termination
when encountering a fatal error during processing of the FILELOCK
statement. If a fatal error occurs, with no ON ERROR clause specified,
the program enters the debugger.

If the ON ERROR clause is used, the value returned by the STATUS
function is the error number.

## EXAMPLE

In the following example, the first FILEUNLOCK statement unlocks
the default file. The second FILEUNLOCK statement unlocks the file
variable FILE.

    OPEN '', 'SLIPPERS' ELSE STOP "CAN'T OPEN SLIPPERS"
    FILELOCK
    FILEUNLOCK
    OPEN 'PIPE' TO FILEVAR ELSE STOP
    FILELOCK FILEVAR
    FILEUNLOCK FILEVAR
