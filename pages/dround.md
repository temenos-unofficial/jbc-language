# DROUND

The DROUND function performs double-precision rounding on a value.
Double-precision rounding uses two words to store a number,
accommodating a larger number than in single-precision rounding,
which stores each number in a single word.

## COMMAND SYNTAX

    DROUND(val.expr [,precision.expr])

NOTE: DROUND affects the internal representation of the numeric
value. It performs the rounding without conversion to and from
string variables. This increases the speed of calculation.

## SYNTAX ELEMENTS

**val.expr** specifies the value to round.

**precision.expr** specifies the precision for the rounding.
Default precision is four places.

## EXAMPLE

       V.PI = 3.14159265358979323846
       CRT 'Default:', DROUND(V.PI)
       FOR V.I = 0 TO 20
          CRT DROUND(V.PI, V.I)
       NEXT V.I

Output:

<pre>
    Default:	3.1416
    3
    3.1
    3.14
    3.142
    3.1416
    3.14159
    3.141593
    3.1415927
    3.14159265
    3.141592654
    3.1415926536
    3.14159265359
    3.14159265359
    3.1415926535898
    3.14159265358979
    3.141592653589793
    3.1415926535897932
    3.14159265358979324
    3.141592653589793238
    3.1415926535897932385
    3.14159265358979323846</pre>
