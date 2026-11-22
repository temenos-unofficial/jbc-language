# Boolean variables

Boolean variables as such don't exist in jBC; the result of a statement like IF (VAR) THEN...
depends on that variable contents:

       IF NOT(unassigned_var) THEN CRT 'Unassigned var is false'
       true_var = 1  ;  false_var = 0
       IF true_var THEN CRT '1 is true'
       IF NOT(false_var) THEN CRT '0 is false'
       a_string = 'YES'
       IF a_string THEN CRT 'Non-empty string is true'
       IF NOT('0.00') THEN CRT '0.00 is false'
       IF NOT('-0.00') THEN CRT '"-0.00" is still false - treated as numeric'
    * and this test depends on PRECISION
       PRECISION 9
       IF NOT('0.00000000000001') THEN CRT '0.00000000000001 is false'  \
             ELSE CRT '0.00000000000001 is true'
       PRECISION 17
       IF NOT('0.00000000000001') THEN CRT '0.00000000000001 is false' \
             ELSE CRT '0.00000000000001 is true with PRECISION 17'
       *------------------------------------------------------------------------
    ANOTHER.METHOD:
    *
      CRT @TRUE
      CRT @FALSE

Compiler warning:

<pre>
    Warning: Variable unassigned_var is never assigned!</pre>

Runtime:

<pre>
    Non-numeric value -- ZERO USED ,
    Variable 'unassigned_var' , Line 1 , Source test.b
    Unassigned var is false
    1 is true
    0 is false
    Non-empty string is true
    0.00 is false
    "-0.00" is still false - treated as numeric
    0.00000000000001 is false
    0.00000000000001 is true with PRECISION 17
    1
    0</pre>
