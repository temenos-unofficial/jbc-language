# READL

READL statement allows a process to read a record from a previously
opened file into a variable and takes a read-only shared lock on the
record. It respects all records locked with the [READU](https://jbc-lang.org/pages/readu.md)
statement but allows other processes using READL to share the same
lock.

## COMMAND SYNTAX

    READL variable1 FROM {variable2,} expression { SETTING setvar }  \
          { ON ERROR statements } \
          { LOCKED statements } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the identifier into which the record will be
read.

**variable2**, if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement if
variable2 is not specified then the default file is assumed.

The expression should evaluate to a valid record key for the file.

If the SETTING clause is specified and the read fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If ON ERROR is specified, the statements following the ON ERROR
clause will be executed for any of the above Incremental File
Errors except error 128.

## NOTES

READL takes a read-only shared record lock whereas [READU](https://jbc-lang.org/pages/readu.md)
takes an exclusive lock. This means that any record, which is read
using READL, can also be read by another process using a READL.
In other words, the lock on the record is 'shared' in that no
[READU](https://jbc-lang.org/pages/readu.md) lock against the same record can be taken.

Similarly, if [READU](https://jbc-lang.org/pages/readu.md) takes a lock then READL will respect
that lock. By comparison, [READU](https://jbc-lang.org/pages/readu.md) takes an exclusive lock
in that the one process retains control over the record.

The usage of READU is already well documented and understood. The
usage of READL allows for an application to present a record to one
or more users such that its integrity is ensured, i.e. the user(s)
viewing the record can be assured that wysiwyg and that no updates
to that record have been made whilst viewing the record.

While it is permissible to [WRITE](https://jbc-lang.org/pages/write.md) a record that has a READL
lock, the intent of READL is to permit a 'read-only' shared lock and
the act of WRITEing this record would not be considered good
programming practice.

READ takes no lock at all and does not respect any lock taken with
[READU](https://jbc-lang.org/pages/readu.md) or READL. In other words, a READ can be performed at
any time and on any record regardless of any existing locks.

Due to limitations on Windows platforms, the READL statement behaves
the same as the READU statement, in other words they both take
exclusive locks.

If the record could not be read because another process already had a
[READU](https://jbc-lang.org/pages/readu.md) lock on the record then one of two actions is taken.
If the LOCKED clause was specified in the statement then the
statements dependent on it are executed.

If no LOCKED clause was specified then the statement blocks (hangs)
until the other process releases the lock. The SYSTEM (43) function
can be used to determine which port has the lock.

If the statement fails to read the record then any statements
associated with the ELSE clause will be executed. If the statement
successfully reads the record then the statements associated with
any THEN clause are executed.

Either or both of THEN and ELSE clauses must be specified with the
statement.

The lock taken by the READL statement will be released by any of the
following events however, be aware that the record will not be fully
released until all shared locks have been released:

The same program with [WRITE](https://jbc-lang.org/pages/write.md), [WRITEV](https://jbc-lang.org/pages/writev.md) or
[MATWRITE](https://jbc-lang.org/pages/matwrite.md) statements writes to the record.

The same program with the DELETE statement deletes the record.

The record lock is released explicitly using the [RELEASE](https://jbc-lang.org/pages/release.md)
statement.

The program stops normally or abnormally.

When a file is OPENed to a local file variable in a subroutine then
the file is closed when the subroutine RETURNS so all locks taken on
that file are released, including locks taken in a calling program.
Files that are opened to [COMMON](https://jbc-lang.org/pages/common.md) variables are not closed
so the locks remain intact.

## EXAMPLE

       OPEN 'F.TEMP' TO f_temp ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO f_temp ELSE
             CRT 'OPEN FAILED'
             STOP
          END
       END
       rec_id = 'REC1'
       READL record FROM f_temp, rec_id LOCKED
          CRT 'Lock failure'
          STOP
       END ELSE NULL
       CRT RECORDLOCKED(f_temp, rec_id)  ;* 2 under Windows, 1 under Unix

See also: [WRITE](https://jbc-lang.org/pages/write.md), [WRITEU](https://jbc-lang.org/pages/writeu.md), [MATWRITE](https://jbc-lang.org/pages/matwrite.md),
[MATWRITEU](https://jbc-lang.org/pages/matwriteu.md), [RELEASE](https://jbc-lang.org/pages/release.md), and [DELETE](https://jbc-lang.org/pages/delete.md)
