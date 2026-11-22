# READU

READU statement allows a program to read a record from previously
opened file into variable. It respects record locking and locks the
specified record for update.

## COMMAND SYNTAX

    READU variable1 FROM {variable2,} expression { SETTING setvar }  \
          { WAIT timeout } { ON ERROR statements } { LOCKED statements }  \
          THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the identifier into which the record will be read.

**variable2** if specified, should be a jBC variable that has
previously been opened to a file using the OPEN statement. If
variable2 is not specified then the default file is assumed.

The **expression** should evaluate to a valid record key for the
file.

If the **SETTING** clause is specified and the read fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If WAIT clause is specified and the record stated in Variable1 is
already locked, READU waits 'timeout' milliseconds before executing
LOCKED statement. If LOCKED clause is not specified WAIT clause does
not effect to the READU behaviour. Without LOCKED clause READU is
blocked until the lock is released regardless to the WAIT clause
parameter.

If ON ERROR is specified, the statements following the ON ERROR
clause will be executed for any of the above Incremental File Errors
except error 128.

## NOTES

If the record could not be read because another process already had a
lock on the record then one of two actions is taken. If the LOCKED
clause was specified in the statement then the statements dependent
on it are executed. If no LOCKED clause was specified then the
statement
blocks (hangs) until the other process releases the lock. Use the
SYSTEM (43) function to determine which port has the lock.

If the statement fails to read the record then any statements associated
with the ELSE clause will be executed. If the statement successfully
reads the record then the statements associated with any THEN clause are
executed. Either or both of THEN and ELSE clauses must be specified with
the statement.

The lock taken by the READU statement will be released by any of the
following events:

The same program with [WRITE](https://jbc-lang.org/pages/write.md), [WRITEV](https://jbc-lang.org/pages/writev.md) or
[MATWRITE](https://jbc-lang.org/pages/matwrite.md) statements writes to the record.

The same program with the DELETE statement deletes the record.

The record lock is released explicitly using the [RELEASE](https://jbc-lang.org/pages/release.md)
statement.

The program stops normally or abnormally.

When a file is OPENed to a local file variable in a subroutine then the
file is closed when the subroutine RETURNS so all locks taken on that
file are released, including locks taken in a calling program. Files that
are opened to [COMMON](https://jbc-lang.org/pages/common.md) variables are not closed so the locks
remain intact.

See also: [WRITE](https://jbc-lang.org/pages/write.md), [WRITEU](https://jbc-lang.org/pages/writeu.md), [MATWRITE](https://jbc-lang.org/pages/matwrite.md),
[MATWRITEU](https://jbc-lang.org/pages/matwriteu.md), [RELEASE](https://jbc-lang.org/pages/release.md), and [DELETE](https://jbc-lang.org/pages/delete.md)

## EXAMPLE

       OPEN 'F.TEMP' TO F.TEMP ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE
             CRT 'OPEN FAILED'
             STOP
          END
       END
       READU V.REC FROM F.TEMP, 'REC1' LOCKED
          CRT 'Lock failure'
          STOP
       END ELSE NULL
       V.REC<-1> = 'A field'
       WRITE V.REC TO F.TEMP, 'REC1'
