# IF (statement)

Allows other statements to be conditionally executed

## COMMAND SYNTAX

    IF expression THEN | ELSE statements

## SYNTAX ELEMENTS

It evaluates the expression to a value of Boolean TRUE or FALSE. If the
expression is TRUE executes then the statements defined by the THEN
clause (if present). If the expression is FALSE executes the statements
defined by the ELSE clause.

The THEN and ELSE clauses may take two different forms being single
and multiple line statements.

The simplest form of either clause is of the form:

    IF A THEN CRT A

Or

    IF A ELSE CRT A

However, expand the clauses to enclose multiple lines of code using the
END keyword as so:

    IF A THEN
        A = A*6
        CRT A
    END ELSE
        A = 76
        CRT A
    END

You can combine the single and multi-line versions of either clause to
make complex combinations of the command. For reasons of readability
it is suggested that where both clauses are present for an IF statement
that the same form of each clause is coded.

## NOTES

IF statements can be nested within either clause to any number of
levels.

## EXAMPLE

    CRT "Are you sure (Y/N) " :
    INPUT Answer, 1_
    IF OCONV (Answer, 'MCU') = "Y" THEN
        GOSUB DeleteFiles
        CRT "Files have been deleted"
    END ELSE
        CRT "File delete was ignored"
    END
