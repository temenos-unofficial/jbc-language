# GROUP

The GROUP function is equivalent to the FIELD function.

## COMMAND SYNTAX

    GROUP(Expression1, Expression2, Expression3, Expression4)

## SYNTAX ELEMENTS

**Expression1** evaluates to the string containing fields to be
extracted.

**Expression2** evaluates to the character(s) delimiting each field
within Expression1.

**Expression3** should evaluate to a numeric value specifying the
number of the first field to extract from Expression1.

**Expression4** evaluates to a numeric value specifying the number
of fields to extract as a group.

## NOTES

Expression2 may evaluate to more than a single character allowing
fields to be delimited with complex expressions.

## EXAMPLE

    CRT GROUP('123:-456:-789:-987:-', ':-', 2, 2)

This example displays the following on the terminal (being the second and
third fields and their delimiter within this string variable):

<pre>
    Expected result: 456:-789
    Output in TAFC R19: 456:-789:-987:-
    Output in TAFJ: -456:-789
    Output in TAFJ R22: as expected.
    </pre>
