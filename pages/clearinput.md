# CLEARINPUT

The CLEARINPUT command clears the terminal type-ahead buffer to allow
the next INPUT statement to force a response from the user.

## COMMAND SYNTAX

    CLEARINPUT

## EXAMPLE

In the following example, the CLEARINPUT statement clears the terminal
type-ahead buffer to provoke a response from the user to the prompt:

    CLEARINPUT
    PRINT "DO YOU WANT TO DELETE THIS FILE?(Y OR N)" ; INPUT X,1

NOTE: The CLEARINPUT command is synonymous with INPUTCLEAR.
