# OPENSER

OPENSER statement is used to handle the Serial IO.

Serial IO to the COM ports on NT and to device files, achieves this
on UNIX by using the sequential file statements. In addition, you
can perform certain control operations using the [IOCTL](https://jbc-lang.org/pages/ioctl.md)
function.

## COMMAND SYNTAX

    OPENSER Path,DevInfo | PIPE TO FileVar THEN | ELSE Statements

## SYNTAX ELEMENTS

**Path** is the pathname of the required device.

**DevInfo** consists of the following:

| Baud  |     | baud rate required                       |
|-------|-----|------------------------------------------|
| Flow  |  y  | X-ON X-OFF flow control (default)        |
|       |  n  | no flow control                          |
|       |  i  | input flow control                       |
|       |  o  | output flow control                      |
|       |     |                                          |
|Parity |  y  | X-ON X-OFF flow control (default)        |
|       |  n  | no flow control                          |
|       |  i  | input flow control                       |
|       |  o  | output flow control                      |

**PIPE** specifies the file is to be opened to a PIPE for reading.

## NOTES

The PIPE functionality allows a process to open a PIPE, once
opened then the process can execute a command via the
[WRITESEQ](https://jbc-lang.org/pages/writeseq.md)/[SEND](https://jbc-lang.org/pages/send.md) statement and then received
the result back via the [GET](https://jbc-lang.org/pages/get.md)/[READSEQ](https://jbc-lang.org/pages/readseq.md) statements.

## EXAMPLES

       FileName = "/dev/pts/1"
       OPENSER FileName TO File ELSE STOP 201, FileName
       WRITESEQ "ls -l" TO File ELSE NULL
       LOOP
          Terminator = CHAR(10)
          WaitTime = 4
          GET Input SETTING Count FROM File UNTIL Terminator RETURNING TermChar \
                WAITING WaitTime THEN
             CRT "Get Ok, Input " :Input: " Count " :Count: "TermChar" :TermChar
          END ELSE
             CRT "Get Timed out Input " :Input: " Count " : Count: " TermChar" \
                :TermChar
          END
       WHILE Input NE "" DO
       REPEAT
