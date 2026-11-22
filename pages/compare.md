# COMPARE

The COMPARE function compares two strings and returns a value
indicating whether or not they are equal.

## COMMAND SYNTAX

    COMPARE(expression1, expression2 {, justification } )

## SYNTAX ELEMENTS

**expression1** is the first string for comparison

**expression2** is the second string for comparison

**justification** specifies how the strings are to be compared. "L"
indicates a left justified comparison. "R" indicates a right justified
comparison. The default is left justification.

The function returns one of the following values:

|Code|    Description                              |
|----|---------------------------------------------|
|-1  |  The first string is less than the second   |
| 0  |  The strings are equal                      |
| 1  |  The first string is greater than the second|

## EXAMPLE

    A = "XY999"
    B = "XY1000"
    R1 = COMPARE(A, B, 'L')
    R2 = COMPARE(A, B, 'R')
    CRT R1, R2

The code above should display 1 -1, which indicates that XY999 is greater than
XY1000 in a left justified comparison and XY999 is less than XY1000 in
a right justified comparison.

***TAFC/TAFJ compatibility note: this code outputs 1  1 under TAFC R13/R19/R22. TAFJ is OK.***

## INTERNATIONAL MODE

When using the COMPARE function in International Mode, the function will
use the currently configured locale to determine the rules by which each
string is considered less than or greater than the other will.
