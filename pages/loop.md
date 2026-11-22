# LOOP

LOOP allows the programmer to specify loops with multiple exit
conditions.

## COMMAND SYNTAX

    LOOP statements1 WHILE | UNTIL expression DO statements2 REPEAT

## SYNTAX ELEMENTS

**statements1** and **statements2** consist of any number of standard
statements include the LOOP statement itself, thus allowing nested loops.

**statements1** will always be executed at least once, after which the
WHILE or UNTIL clause is evaluated.

**expression** is tested for Boolean TRUE/FALSE by either the WHILE
clause or the UNTIL clause. When tested by the WHILE clause statements2
will only be executed if expression is Boolean TRUE. When tested by the
UNTIL clause, statements2 will only be executed if the expression
evaluates to Boolean FALSE.

**REPEAT** causes the loop to start again with the first statement
following the LOOP statement.

## NOTES

See also: [BREAK](https://jbc-lang.org/pages/break.md), [CONTINUE](https://jbc-lang.org/pages/continue.md)

## EXAMPLE

      IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
      EXECUTE 'SELECT ' : V.HOME : '/jbcmessages SAMPLE 10' RTNLIST V.MSG.L
    * Retrieve @IDs one by one
       LOOP
          REMOVE V.ID FROM V.MSG.L SETTING V.STATUS
          CRT V.ID
          IF V.STATUS EQ 0 THEN BREAK   ;* end of list reached
       REPEAT

Output looks like:

<pre>
    INV_FILE_TYPE
    DEVICE_QUIT
    RTN_NOGOSUB
    ARRAY_ILLEGAL_SIZE
    DIFF_COMMON
    QLNOVERB
    QLPARAMERR
    SP-HoldCount
    603
    1134</pre>

The loop used in this example can also be defined this way:

       LOOP
          REMOVE V.ID FROM V.MSG.L SETTING V.STATUS
          CRT V.ID
       UNTIL V.STATUS EQ 0
       REPEAT
