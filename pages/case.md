# CASE

The CASE statement allows the programmer to execute a particular
sequence of instructions based upon the results of a series of test
expressions.

## COMMAND SYNTAX

        BEGIN CASE
        CASE expression statement(s)
        CASE expression
        *statement(s)
        *. . .
        END CASE

## SYNTAX ELEMENTS

The BEGIN CASE and END CASE statements bound the CASE structure. Within
this block, an arbitrary number of CASE expression statements may exist
followed by any number of jBC statements. The expression should
evaluate to a TRUE or FALSE result. The evaluation of each expression
at execution time is in order. If the expression returns a TRUE result,
it then executes the statements below. On completion of the associated
statements, execution will resume at the first statement following
the END CASE.

## NOTES:

A default action (to trap error conditions for instance)
may be introduced by using an expression that is always TRUE, such as
"CASE 1". This should always be the last expression in the CASE block.

## EXAMPLE

       V.STRING = 'B'
       GOSUB CHK.IT
       V.STRING = 'ABC'
       GOSUB CHK.IT
       STOP
    *
    CHK.IT:
    *
       BEGIN CASE
       CASE V.STRING EQ 'A'
          CRT 'an A'
       CASE  V.STRING EQ 'B'
          CRT 'a B'
       CASE V.STRING EQ 'C'
          CRT 'a C'
       CASE 1
          CRT 'neither A nor B nor C'
       END CASE
       RETURN
    END

Output:

<pre>
    a B
    neither A nor B nor C
     </pre>
