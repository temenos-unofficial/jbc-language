# WRITESEQF

WRITESEQF statement is used to write new lines to a file opened for
sequential processing, and to ensure that data is physically written to
disk (that is, not buffered) before the next statement in the program is
executed.

## COMMAND SYNTAX

    WRITESEQF expression { ON | TO } file.variable [ ON ERROR statements ]  \
              { THEN statements [ ELSE statements ] | ELSE statements }

The sequential file must be open, and the end-of-file marker must be
reached before you can write to the file. You can use the
[FILEINFO](https://jbc-lang.org/pages/fileinfo.md) function to determine the number of the line
about to be written.

Normally, when you write a record using the [WRITESEQ](https://jbc-lang.org/pages/writeseq.md)
statement, the record is moved to a buffer that is periodically
written to disk. If a system failure occurs, you could lose all
the updated records in the buffer. The WRITESEQF statement forces
the buffer contents to be written to disk; the program does not
execute the statement following the WRITESEQF statement
until the buffer is successfully written to disk.

A WRITESEQF statement following several WRITESEQ
statements ensures that all buffered records are written to disk.
WRITESEQF is intended for logging applications and should not
be used for general programming. It increases the disk I/O of
your program and therefore degrades performance. file.variable
specifies a file opened for sequential access.

The value of expression is written to the file as the next line,
and the THEN statements are executed. If THEN statements are not
specified, program execution continues with the next statement;
if the specified file cannot be accessed or does not exist, the
ELSE statements are executed; any THEN statements are ignored.

If expression or file.variable evaluates to the null value, the
WRITESEQF statement fails and the program terminates with a
run-time error message.

*The ON ERROR Clause*

The ON ERROR clause is optional in the WRITESEQF statement. Its
syntax is the same as that of the ELSE clause. The ON ERROR clause
lets you specify an alternative for program termination when a
fatal error is encountered while the WRITESEQF statement is being
processed.
