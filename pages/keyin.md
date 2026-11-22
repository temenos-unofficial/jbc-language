# KEYIN

KEYIN function is used to read a single character from the input buffer
and return it.

## COMMAND SYNTAX

    KEYIN()

KEYIN uses raw keyboard input, therefore all special character handling
(for example, backspace) is disabled. System special character handling
(for example, processing of interrupts) is unchanged.

## EXAMPLE

Output current time and date in the current line on the terminal until user
presses q or Q key.

       V.HOME = @(0)   ;* remember cursor position at the start of the current line
       LOOP
          LOOP
             V.BUFF = SYSTEM(14)    ;* check if there's anything in keyboard buffer
             IF V.BUFF NE 0 THEN BREAK
             CRT V.HOME:TIMEDATE():     ;* e.g. 22:27:08 24 OCT 2012
             MSLEEP 3000
          REPEAT
          V.KEY = UPCASE( KEYIN() )
          IF V.KEY EQ 'Q' THEN BREAK    ;* exit if q or Q was pressed
       REPEAT

***TAFJ note: routine with KEYIN() finishes without waiting for input. The routine above won't work also because SYSTEM(14) doesn't work either.***
