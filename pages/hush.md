# HUSH

Use the HUSH statement to suppress the display of all output normally
sent to a terminal during processing. HUSH also suppresses output to a
COMO file.

HUSH acts as a toggle. If it is used without a qualifier, it changes
the current state. Do not use this statement to shut off output
display unless you are sure the display is unnecessary. When you use
HUSH ON, all output is suppressed including error messages and requests
for information.

## COMMAND SYNTAX

    HUSH { ON | OFF | expression }

## EXAMPLE

       CRT 'PASSWORD:':
       HUSH ON
       INPUT V.PASSWORD
       HUSH OFF

***TAFJ note: HUSH ON doesn't hide user input. Workaround: use ECHO OFF.***
