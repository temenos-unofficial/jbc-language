# INS

The INS statement allows the insertion of elements into a dynamic
array.

## COMMAND SYNTAX

    INS expression BEFORE Var<expression1{, expression2{, expression3}}>

## SYNTAX ELEMENTS

**expression** evaluates to the element to be inserted in the dynamic
array.

**expression1** expression2 and expression3 should all evaluate to
numeric values and specify the Field, Value and Sub-Value before
which the new element is to be inserted.

## NOTES

Specifying a negative value to any of the expressions 1 through 3
will cause the element to append as the last Field, Value or
Sub-Value rather than at a specific position. Only one expression
may be negative otherwise only the first negative value is used
correctly while the others are treated as the value 1.

The statement will insert NULL Fields, Values or Sub-Values
accordingly if any of the specified insertion points exceeds the
number currently existing.

## EXAMPLE

       Values = ''
       FOR I = 1 TO 50
          INS I BEFORE Values<-1>
       NEXT I
       FOR I = 2 TO 12
          INS I*7 BEFORE Values<7,I>
       NEXT I
       CRT FMT(Values, 'MCP')

The output is (one line):

<pre>
    1^2^3^4^5^6^7]14]21]28]35]42]49]56]63]70]77]84^8^9^10^11^12^13^14^15^16^
    17^18^19^20^21^22^23^24^25^26^27^28^29^30^31^32^33^34^35^36^37^38^39^40^
    41^42^43^44^45^46^47^48^49^50</pre>
