# OPENSEQ

OPENSEQ is used to open a file for sequential writing and/or
reading.

## COMMAND SYNTAX

    OPENSEQ Path{,File} {READONLY} TO FileVar { LOCKED statements }  \
            THEN | ELSE statements

## SYNTAX ELEMENTS

**Path** specifies the relative or absolute path of the target
directory or file.

**File** specifies additional path information of the target
file.

**FileVar** contains the file descriptor of the file when the
open was successful.

**Statements** are conditional jBC statements.

## NOTES

If the file does not exist or cannot be opened it then executes
the ELSE clause. However, if JBASICEMULATE is set for Sequoia
(use value "seq") emulation then OPENSEQ will create the file if it
does not exist. This behavior can also be achieved by specifying
"openseq_creates = true" in Config_EMULATE for the emulation being
used. Once open a lock is taken on the file. If the lock cannot be
taken then the LOCKED clause is executed if it exists otherwise the
ELSE clause is executed. If specified the READONLY process takes a
read lock on the file, otherwise it takes a write lock. The specified
file can be a regular, pipe or special device file. Locks are only
taken on regular file types. Once open the file pointer is set to the
first line of sequential data.

## EXAMPLE 1

Create a flat file and write to it. If file already exists - append data to it:

       V.DIR.OUT = '.'
       V.FILE.OUT = 'report.txt'
       OPENSEQ V.DIR.OUT, V.FILE.OUT TO F.FILE.OUT THEN
          SEEK F.FILE.OUT, 0, 2 ELSE  ;* go to the end
             CRT 'Seek error'
             STOP
          END
          WRITESEQ 'One more line' TO F.FILE.OUT ELSE
             CRT 'Write error'
             STOP
          END
       END ELSE
          WRITESEQ 'Line 1' TO F.FILE.OUT ELSE
             CRT 'Write error'
             STOP
          END
       END

## EXAMPLE 2

Run the previous example several times, then - this one
(flat file will be read and proceeded line-by-line):

       V.DIR.IN = '.'
       V.FILE.IN = 'report.txt'
       OPENSEQ V.DIR.IN, V.FILE.IN TO F.FILE.IN ELSE
          CRT 'Failed to open', V.FILE.IN
          STOP
       END
       V.LINE.NO = 0
       LOOP
          READSEQ V.LINE FROM F.FILE.IN ELSE BREAK
          V.LINE.NO ++
          CRT '[' : V.LINE.NO : ']' : V.LINE
       REPEAT

Output will look like:

<pre>
    [1]Line 1
    [2]One more line
    [3]One more line
    ...</pre>
