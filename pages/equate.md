# EQUATE

Use EQUATE to declare a symbol equivalent to a literal, variable or
simple expression.

## COMMAND SYNTAX

    EQU{ATE} symbol TO expression

## SYNTAX ELEMENTS

**symbol** is the name of the symbol to use; can be any name that
would be valid for a variable.

**expression** can be a literal, a variable or a simple expression.

## NOTES

Sensible use of EQUATEd symbols can make your program easier to
maintain, easier to read, and more efficient.

Efficiency can be enhanced because the address of an EQUATEd value
is computed during compilation and is substituted for each occurrence
of the symbol name. Unlike the address of a variable, which must be
computed for each access during run time, the address of a symbol is
always known. This significantly reduces the processing overhead
involved in accessing a particular value. See also: the example for
a more detailed explanation of the other benefits.

Enhance Readability by referring to say, QTY rather than INV_LINE(4).
You would simply "EQUATE QTY TO INV_LINE(4)" at an early stage in the
program. This can also help with maintenance of the program,
particularly in situations where record layouts might change. For
example, if the quantity field moves to INV_LINE(6), you only have
to change one line in your program.

## EXAMPLE

       DIM NV_LINE(10)
       MAT NV_LINE = 100
       COMMON FLAG
       EQUATE NO_CHARGE TO FLAG
       EQUATE CR TO CHAR (13), TRUE TO 1, FALSE TO 0
       EQUATE PRICE TO NV_LINE(7), TAX TO 0.175
       EQUATE DASHES TO "-------"
       IF NO_CHARGE = TRUE THEN PRICE = 0
       CRT "Tax = ":PRICE * TAX:CR:DASHES

Output:

<pre>
    Tax = 17.5
    -------</pre>
