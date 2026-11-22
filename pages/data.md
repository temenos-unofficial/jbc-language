# DATA

The DATA statement stacks the series of expressions on a terminal input
FIFO stack. Terminal input statements will then treat this data as
if entered at the keyboard.

## COMMAND SYNTAX

    DATA expression {, expression ...}

## SYNTAX ELEMENTS

The expression may evaluate to any data type; views each comma-separated
expression as one line of terminal input.

## NOTES

The data stacked for input will subsequently be treated as input by any
jBC program. Therefore use it before PERFORM/EXECUTE, CHAIN or any other
method of transferring program execution. Use also to stack input for
the currently executing program; do not use to stack input back to an
executing program.

When a jBC program detects stacked data, it is taken as keyboard input
until the stack is exhausted. The program will then revert to the
terminal device for subsequent terminal input.

Stacked data delimited by field marks (xFE) will be treated as a series
of separate terminal inputs.

See also: [CLEARDATA](https://jbc-lang.org/pages/cleardata.md)

## EXAMPLE

Program test.b:

       DATA '12345'
       DATA '67890'
       EXECUTE 'test2'

Program test2.b:

       INPUT V.DATA1
       INPUT V.DATA2
       CRT 'I got ' : V.DATA1 : ' and ' : V.DATA2

If test2 is run by itself, it asks for user input. If test is run, the
output is:

<pre>
    I got 12345 and 67890</pre>
