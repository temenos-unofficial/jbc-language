# CRT

The CRT statement sends data directly to the terminal, even if a
PRINTER ON statement is currently active.

## COMMAND SYNTAX

    CRT expression {, expression..} {:}

## SYNTAX ELEMENTS

An expression can evaluate to any data type. The CRT statement will
convert the result to a string type for printing. Expressions
separated by commas will be sent to the screen separated by a
tab character.

The CRT statement will append a newline sequence to the final
expression unless it is terminated with a colon (":") character.

## NOTES

As the expression can be any valid expression, it may have output
formatting applied to it.

A jBC program is normally executed using buffered output mode. This
means that data is not flushed to the terminal screen unless a
newline sequence is printed or terminal input is requested. This
makes it very efficient. However you can force output to be flushed
to the terminal by printing a null character CHAR (0). This has the
same effect as a newline sequence but without affecting screen output.

For compatibility, use DISPLAY in place of CRT.

## EXAMPLES

       V.VAR = 5
       CRT V.VAR           ;* 5
       V.VAR ++
       CRT V.VAR           ;* 6 (on the next line)
       V.VAR ++
       CRT ''              ;* start a new line
       CRT V.VAR           ;* 7 (2 lines below "6")
       V.RESULT = 50
       CRT 'The result: ':
       CRT V.RESULT        ;* will output: "The result: 50" on the same line
       MSLEEP(3000)
       CRT @(-1)                    ;* clears the screen and homes the cursor
       CRT @(40, 12):'Hello'        ;* will start output at row 11, column 39
       CRT ''
       V.NUM = 39
       V.STRING = 'In the year of'
       CRT V.STRING : ' ' : V.NUM    ;* In the year of 39
       CRT V.STRING, V.NUM           ;* In the year of  39
       V.LINE = '39R'
       V.STRING = 'In the year of'
       CRT V.STRING V.LINE             ;* same as FMT(V.STRING, '39R')
       V.VAR = 5
       CRT V.VAR > 1           ;* Result of an expression (1 in this case)
       CRT @SYS.BELL           ;* rings the bell
