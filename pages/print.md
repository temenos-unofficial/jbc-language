# PRINT

PRINT statement sends data directly to the current output device like terminal
or printer.

## COMMAND SYNTAX

    PRINT expression {, expression...} {:}

## SYNTAX ELEMENTS

An **expression** can evaluate to any data type. The PRINT statement will
convert the result to a string type for printing. Expressions separated by
commas will be sent to the output device separated by a tab character.

The PRINT statement will append a newline sequence to the final expression
unless it is terminated with a colon ":" character.

## NOTES

As the expression can be any valid expression, it may have output formatting
applied to it.

If a PRINTER ON statement is currently active then output will be sent to the
currently assigned printer form queue.

See also: SP-ASSIGN command and [CRT](https://jbc-lang.org/pages/crt.md).

## EXAMPLES

       A = 3
       PRINT DQUOTE(A 'R#5')            ;*  "    3"
       PRINT @(8,20) : "Patrick" :
