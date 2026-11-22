# FILELOCK

Use the FILELOCK statement to acquire a lock on an entire file. This
prevents other users from updating the file until the program releases
it. A FILELOCK statement that does not specify lock.type is equivalent
to obtaining an update record lock on every record of the file. An open
file is specified by file.variable. If no file.variable is specified, the
default file is assumed; if the file is neither accessible nor open, the
program enters the debugger.

## COMMAND SYNTAX

    FILELOCK filevar { LOCKED statements } { ON ERROR statements }

    FILEUNLOCK filevar { ON ERROR statements }

## DESCRIPTION

When the FILELOCK statement is executed, it will attempt to take an
exclusive lock on the entire file. If there are any locks currently
outstanding on the file, then the statement will block until there are
no more locks on the file. The use of the LOCKED clause allows the
application to perform an unblocked operation.

When the FILELOCK statement is blocked waiting for a lock, other
processes may continue to perform database operations on that file,
including the removal of record locks and the taking of record locks.
Once the FILELOCK is taken, it will block ALL database accesses to the
file whether or not the access involves record locks. i.e. a READ will
block once it has been executed, as will, CLEARFILE etc,. The lock
continues until the file is closed, the program terminates, or a
FILEUNLOCK statement is executed.

NOTE: The FILELOCK statement might differ to those found on other vendors
systems. You should also not that the use of these statements for other
than administration work, for example, within batch jobs, is not
recommended.
The replacement of such with more judicious use of item locks is
advised.

**IMPLEMENTATION NOTES**

The FILELOCK command is implemented using the native locking mechanism
of the operating system and is entirely at its mercy. Because of this,
you may see some slight implementation differences between operating
systems. These comments on native locking do not apply to the NT
platform as TAFC uses the NT locking mechanism.

The uses of the native (UNIX) locking mechanism means the file in
question MUST NOT use the jBASE locking mechanism. You can set a
file to use the native locking mechanism by using the jchmod
command:

jchmod +N filename {filename ...}

Alternatively, like this when the file is originally created:

<pre>
    CREATE-FILE filename 1,1 23,1 NETWORK=TRUE</pre>

If the file continues to use the jBASE record locking, then the ON
ERROR clause will be taken and the SYSTEM(0) and [STATUS](https://jbc-lang.org/pages/status.md)
functions will set to 22 to indicate the error.

## EXAMPLES

    OPEN '','SLIPPERS' TO FILEVAR ELSE STOP "CAN'T OPEN FILE"
    FILELOCK FILEVAR LOCKED STOP 'FILE IS ALREADY LOCKED'
    FILEUNLOCK DATA
    OPEN '','SLIPPERS' ELSE STOP "CAN'T OPEN FILE"
    FILELOCK LOCKED STOP 'FILE IS ALREADY LOCKED'
    PRINT "The file is locked."
    FILEUNLOCK
