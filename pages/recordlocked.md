# RECORDLOCKED

RECORDLOCKED function is called to ascertain the status of a record
lock.

## COMMAND SYNTAX

    RECORDLOCKED(filevar, recordkey)

## SYNTAX ELEMENTS

**filevar** is a file variable from a previously executed OPEN
statement.

**recordkey** is an expression for the record id that will be
checked.

## NOTES

RECORDLOCKED returns an integer value to indicate the record lock
status of the specified record id.

| Code | Description                               |
|------|-------------------------------------------|
|3     |  Locked by this process by a FILELOCK     |
|2     |  Locked by this process by a READU        |
|1     |  Locked by this process by a READL        |
|0     |  Not locked                               |
|-1    |  Locked by another process by a READL     |
|-2    |  Locked by another process by a READU     |
|-3    |  Locked by another process by a FILELOCK  |

If the return value is negative, then the SYSTEM(43) and STATUS function
calls can be used to determine the port number of the program that holds
the lock. If -1 is returned, more than 1 port could hold the lock and so
the port number returned will be the first port number found.

## EXAMPLE

Run this program from one session, wait for "RECORD LOCKED. PRESS ANY KEY TO WRITE"
message, then run it in another session:

       OPEN 'F.TEMP' TO F.TEMP ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE
             CRT 'OPEN FAILED'
             STOP
          END
       END
       READU V.REC FROM F.TEMP, 'REC1' LOCKED
          CRT 'Lock failure (' : RECORDLOCKED(F.TEMP, 'REC1') : ')'
          STOP
       END ELSE NULL
       PROMPT 'RECORD LOCKED. PRESS ANY KEY TO WRITE'
       INPUT DUMMY
       V.REC<-1> = 'A field'
       WRITE V.REC TO F.TEMP, 'REC1'
