# INPUT

The INPUT statement allows the program to collect data from the current
input device, which will normally be the terminal keyboard but may be
stacked input from the same or separate program.

## COMMAND SYNTAX

    INPUT {@ (expression1 {, expression2 )}{:} Var{{, expression3}, expression4} \
          {:}{_} { WITH expression5 } { FOR expression6 THEN | ELSE statements }

## SYNTAX ELEMENTS

**@(expression1, expression2)** allows the screen cursor to be
positioned to the specified column and row before the input prompt is
sent to the screen. The syntax for this is the same as the @( )
function described earlier.

**Var** is the variable in which the input data is to be stored.

**expression3**, when specified, should evaluate to a numeric value.
This will cause input to be terminated with an automatic newline
sequence after exactly this number of characters has been input.
If the _ option is specified with expression4 then the automatic
newline sequence is not specified but any subsequent input characters
are belled to the terminal and thrown away.

**expression4** when specified, should evaluate to a sequence of 1
to 3 characters. The first character will be printed expression3
times to define the field on the terminal screen. At the end of the
input if less than expression3 characters were input then the rest
of the field is padded with the second character if it was supplied.
If the third character is supplied then the cursor will be
positioned after the last character input rather than at the end
of the input field.

The : option, when specified, suppress the echoing of the newline
sequence to the terminal. This will leave the cursor positioned
after the last input character on the terminal screen.

WITH expression5 allows the default input delimiter (the newline
sequence) to be changed. When specified, expression5, should
evaluate to a string of up to 256 characters, each of which may
delimit the input field. If this clause is used then the newline
sequence is removed as a delimiter and must be specified
explicitly within expression5 as CHAR(10).

The "FOR" clause allows the "INPUT" statement to time out after a
specified waiting period instead of blocking as normal Expression6
should evaluate to a numeric value, which will be taken as the
number of deci-seconds (tenths of a second) to wait before timing
out. The time-out value is used as the time between each keystroke
and should a time-out occur, Var would hold the characters that
were input until the time-out.

The FOR clause requires either the THEN and ELSE clauses or both;
if no time-out occurs the THEN clause is taken. If a time-out does
occur, the ELSE clause is taken.

## NOTES

The INPUT statement will always examine the data input stack before
requesting data from the input device. If data is present on the
stack then it is used to satisfy INPUT statements one field at a
time until the stack is exhausted. Once exhausted, the INPUT statement
will revert to the input device for further input. There is no way
(by default) to input a null field to the INPUT@ statement. If the
INPUT@ statement receives the newline sequence only as input, then
the Var will be unchanged. Use the INPUTNULL statement to define a
character that indicates a NULL input.

Use the CONTROL-CHARS command to control whether or not control
characters (i.e. those outside the range x'1F' - x'7F') are
accepted by INPUT.

See also: [IN](https://jbc-lang.org/pages/in.md), [INPUTNULL](https://jbc-lang.org/pages/inputnull.md).

***TAFJ note: INPUT .. FOR counts time in seconds and not in 10th of seconds as TAFC does.***

## EXAMPLE

Ask user for an input; time limit is 60 seconds; every 3 seconds the
remaining time is updated on user screen.

       V.TIMEOUT = 60
       GOSUB UPD.CNT
       V.ANS = ''
       LOOP
       WHILE V.ANS EQ '' DO
          INPUT V.ANS, 1 : FOR 30 ELSE
             V.TIMEOUT -= 3
             IF V.TIMEOUT LE 0 THEN BREAK
             GOSUB UPD.CNT
          END
       REPEAT
       IF V.ANS NE '' THEN CRT 'The choice was', DQUOTE(V.ANS)
       ELSE CRT "The choice wasn't done"
       STOP
    UPD.CNT:
       CRT @(0):'Seconds left: ': FMT(V.TIMEOUT, '2R') : '. Your choice':
       RETURN

## EXAMPLE 2

Pad the input field.

Code:

       CRT @(-1)
       INPUT @(17,2):the_input,50,'_..':_

User screen:

                        ? _________________________________________________

See also: [PROMPT](https://jbc-lang.org/pages/prompt.md).
