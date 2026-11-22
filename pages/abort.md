# ABORT

The ABORT statement terminates the current running program and the
program that called it.

## COMMAND SYNTAX

    ABORT {message.number {, expression ...}}

## SYNTAX ELEMENTS

The optional message.number provided with the statement must be a
numeric value, which corresponds to a record key in the TAFC error
message file.

A single expression or a list of expression(s) may follow the
message.number. Where more than one expression is listed, they must be
delimited by the use of the comma character. The expression(s)
correspond to the parameters that need passing to the error file
record to print it.

The optional message.number and expression(s) given with the command
are parameters or resultants provided as variables, literal strings,
expressions, or functions.

## NOTES

Use this statement to terminate the execution of a jBC program together
with any calling program. It will then optionally display a message,
and return to the shell prompt.

The error file holds the optional message displayed on terminating the
program. For successful printing of the message, parameters such as
linefeeds, clearscreen, date and literal strings may also be required.
Setting the Command Level Restart option can alter operation of this
command.

## EXAMPLE

    * Open a file with random name (just to make sure that it doesn't exist)
       V.FNAME = ''
       FOR V.J = 1 TO 8
          V.RND = RND(26) + 65
          V.FNAME := CHAR(V.RND)        ;* A...Z
       NEXT V.J
       OPEN V.FNAME TO F.RAND ELSE ABORT 201, V.FNAME

Sample program output:

<pre>
     &lowast;&lowast;&lowast; Error [ 201 ] &lowast;&lowast;
    Unable to open file XCICLJPH</pre>
