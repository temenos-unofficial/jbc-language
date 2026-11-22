# ECHO

The ECHO statement will turn on or off the echoing of characters
typed at the keyboard.

## COMMAND SYNTAX

    ECHO ON

    ECHO OFF

    ECHO expression

## SYNTAX ELEMENTS

Use the statement with the keywords ON and OFF to specify echoing or
not. If used with an expression, then the expression should evaluate
to a Boolean TRUE or FALSE result.

TRUE: echoing on

FALSE: echoing off.

## NOTES

Use the SYSTEM function to determine the current state of character
echoing. SYSTEM(24) returns Boolean TRUE if enabled and returns Boolean
FALSE if disabled.

## EXAMPLES

    ECHO OFF
    CRT "Enter your password " :
    INPUT Password
    ECHO ON
    .....

This will disable the character input echoing while typing in a password.

***TAFJ R23 note: user input can be seen after Enter is pressed, even without ECHO ON at the end.***
