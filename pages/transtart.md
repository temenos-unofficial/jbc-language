# TRANSTART

In transaction processing, TRANSTART statement is used to mark the
beginning of a transaction.

## COMMAND SYNTAX

    TRANSTART { SYNC }{start-text} [ THEN statement | ELSE statement ]

## SYNTAX ELEMENTS

**SYNC** is an option to force the updates to be flushed at
transaction end or abort. start-text specifies an optional text
string to save with the transaction start record.

**THEN** or **ELSE** (or both) statement is required. The THEN
clause will be executed if the transaction is successfully started.
The ELSE clause will be executed if the transaction start fails for
any reason.

## NOTES

Record locks set during the transaction will not be released until a
[TRANSEND](https://jbc-lang.org/pages/transend.md) or [TRANSABORT](https://jbc-lang.org/pages/transabort.md) statement is
processed.

A program (or series of programs) can only have one active
transaction at one time. If another TRANSTART statement is encountered
whilst a transaction is active, a run-time error will be generated.

## Transactions-related examples

## EXAMPLE 1

Write to file without transactions:

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       EXECUTE 'LIST F.TEMP *A1 *A2 *A3'
       PROMPT 'Press any key to continue'
       INPUT DUMMY
       EXECUTE 'LIST F.TEMP *A1 *A2 *A3'

Output: LIST will show the same results both times:

<pre>
    LIST F.TEMP &lowast;A1 &lowast;A2 &lowast;A3
    &nbsp;
    DICT F.TEMP...    &lowast;A1...........    &lowast;A2...........    &lowast;A3...........
    &nbsp;
    REC1              LINE 1            LINE 2            LINE 3
    &nbsp;
     1 Records Listed</pre>

Write to file in a transaction:

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       TRANSTART ELSE
          CRT 'ERROR STARTING TXN'
          STOP
       END
       CRT TRANSQUERY()   ;* 1 - we're inside a transaction
       CRT SYSTEM(47)     ;* another method to check it
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       EXECUTE 'LIST F.TEMP *A1 *A2 *A3'
       PROMPT 'Press any key to continue'
       INPUT DUMMY
       TRANSEND THEN CRT 'TXN WRITTEN'
       EXECUTE 'LIST F.TEMP *A1 *A2 *A3'

Until transaction is over -- no records will be shown:

<pre>
    LIST F.TEMP &lowast;A1 &lowast;A2 &lowast;A3
    &nbsp;
    DICT F.TEMP...    &lowast;A1...........    &lowast;A2...........    &lowast;A3...........
    &nbsp;
     No Records Listed
    &nbsp;
    Press any key to continue
    &nbsp;
    LIST F.TEMP &lowast;A1 &lowast;A2 &lowast;A3
    &nbsp;
    DICT F.TEMP...    &lowast;A1...........    &lowast;A2...........    &lowast;A3...........
    &nbsp;
    REC1              LINE 1            LINE 2            LINE 3
    &nbsp;
     1 Records Listed</pre>

## EXAMPLE 2

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'    ;* write before a transaction
       TRANSTART ELSE
          CRT 'ERROR STARTING TXN'
          STOP
       END
       WRITE V.REC.INIT TO F.TEMP, 'REC2'
       TRANSABORT THEN CRT 'TXN ABORTED'     ;* abandon the second write
       WRITE V.REC.INIT TO F.TEMP, 'REC3'    ;* write after a transaction
       EXECUTE 'LIST F.TEMP *A1 *A2 *A3'

Output:

<pre>
    LIST F.TEMP &lowast;A1 &lowast;A2 &lowast;A3
    &nbsp;
    DICT F.TEMP...    &lowast;A1...........    &lowast;A2...........    &lowast;A3...........
    &nbsp;
    REC1              LINE 1            LINE 2            LINE 3
    REC3              LINE 1            LINE 2            LINE 3
    &nbsp;
     2 Records Listed</pre>
