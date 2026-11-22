# IN

The IN statement allows the program to receive raw data from the
input device, which is normally the terminal keyboard, one character
at a time.

## COMMAND SYNTAX

    IN Var { FOR expression THEN | ELSE statements }

## SYNTAX ELEMENTS

**Var** will be assigned the numeric value (0 - 255 decimal) of the
next character received from the input device. The statement will
normally wait indefinitely (block) for a character from the keyboard.

Specifying the FOR clause to the IN statement allows the statement
to stop waiting for keyboard after a specified amount of time. The
expression should evaluate to a numeric value, which will be taken
as the number of deci-seconds (tenths of a second) to wait before
abandoning the input.

The **FOR** clause must have either or both of the THEN or ELSE
clauses If a character is received from the input device before the
time-out period then Var is assigned its numeric value and the THEN
clause is executed (if present). If the input statement times out
before a character is received then Var is unaltered and the ELSE
clause is executed (if present).

## NOTES

See also: [INPUT](https://jbc-lang.org/pages/input.md), [INPUTNULL](https://jbc-lang.org/pages/inputnull.md).

***TAFJ note: IN statement doesn't wait for user input, Var returns as empty string.***

## EXAMPLE

       LOOP
          IN in_key
          IF in_key EQ 27 THEN ;* ESC seen
             IN in_key_2 FOR 2 THEN ;* Function Key?
                IN in_key_3 FOR 2 THEN
                   CRT ''
                   BEGIN CASE
                   CASE in_key_2 EQ 79 AND in_key_3 EQ 80
                      CRT 'F1 detected'
                   CASE in_key_2 EQ 79 AND in_key_3 EQ 81
                      CRT 'F2 detected'
                   END CASE
                END
             END ELSE
                CRT ''
                CRT 'ESC pressed, exiting'
                STOP
             END
          END
       REPEAT
