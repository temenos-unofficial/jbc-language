# CONTINUE

The CONTINUE statement is the complimentary statement to the BREAK statement
without arguments.

## COMMAND SYNTAX

    CONTINUE

Use the statement within a loop to skip the remaining code in the current
iteration and proceed directly on to the next iteration.

## NOTES

See also: [BREAK](https://jbc-lang.org/pages/break.md), [EXIT](https://jbc-lang.org/pages/exit.md)
The compiler will issue a warning message and ignore the statement if it is
found outside an iterative loop such as FOR...NEXT, LOOP...REPEAT.

## EXAMPLE

       num_array = ''
       FOR i = 1 TO 10
          IF i EQ 3 THEN CONTINUE
          num_array<-1> = i
       NEXT i
       CRT FMT(num_array, 'MCP')    ;* 1^2^4^5^6^7^8^9^10
