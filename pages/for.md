# FOR

The FOR statement allows the construction of looping constructs within
the program, which is controlled by a counting variable; this can be
terminated early by expressions tested after every iteration.

## COMMAND SYNTAX

    FOR var=expression1 TO expression2 { STEP expression3 }  \
       { WHILE | UNTIL expression4 }
    ...
    NEXT {var}

## SYNTAX ELEMENTS

**var** is the counting variable used to control the loop. The first
time the loop is entered var is assigned the value of expression1,
which must evaluate to a numeric value. After each iteration of the
loop, var is automatically incremented by one.

**expression2** must also evaluate to a numeric value as it causes the
loop to terminate when the value of var is greater than the value of
this expression. expression2 is evaluated at the start of every
iteration of the loop and compared with the value of expression1.

If the STEP expression3 clause is included within the statement, var
will automatically be incremented by the value of expression3 after
each iteration of the loop. expression3 is evaluated at the start of
each iteration.

**expression3** may be negative, in which case the loop will terminate
when var is less than expression2.
The statement may optionally include either an evaluated WHILE or UNTIL
clause (not both), before each iteration of the loop. When the WHILE
clause is specified the loop will only continue with the next iteration
if expression4 evaluates to Boolean TRUE. When the UNTIL clause is
specified the loop will only continue with the next iteration if
expression4 evaluates to Boolean FALSE.

## NOTES

Because expression2 and expression3 must be evaluated upon each
iteration of the loop, you should only code complex expressions here
if they may change within each iteration. If the values they yield will
not change then you should assign the value of these expressions to a
variable before coding the loop statement. You can replace expressions
3 and 4 with these variables. This can offer large performance increases
where complex expressions are in use.

See also: [BREAK](https://jbc-lang.org/pages/break.md), [CONTINUE](https://jbc-lang.org/pages/continue.md).

## EXAMPLE

       V.ARRAY = ''
       FOR V.I = 1 TO 10
          V.ARRAY<-1> = 'Element #' : V.I
       NEXT V.I
       CRT V.ARRAY<6>                          ;* Element #6
       //
       FOR V.I = 10 TO 1 STEP -2 WHILE V.I GT 3
          DEL V.ARRAY<V.I>
       NEXT V.I
       CRT V.ARRAY<6>                          ;* Element #9
       CRT V.ARRAY<3>                          ;* Element #3
