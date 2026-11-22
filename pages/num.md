# NUM

NUM function is used to test arguments for numeric values.

## COMMAND SYNTAX

    NUM(expression)

## SYNTAX ELEMENTS

**expression** may evaluate to any data type.

## NOTES

Not exactly it checks that every character in expression is a numeric -
rather if an expression can be considered as a number.

To execute user code migration from older systems correctly, the
NUM function will accept both a null string and the single
characters ".", "+", and "-" as being numeric.

If running jBC in ros emulation the "." , "+" and "-" characters
would not be considered numeric.

## EXAMPLES (prime emulation)

       CRT NUM('')                     ;* 1
       CRT NUM('123334440.12')         ;* 1
       CRT NUM('1233344.40.12')        ;* 0
       CRT NUM('1,233,344.40')         ;* 0 - thousand delimiters don't do
       CRT NUM('1 233 344.40')         ;* 0 - neither do spaces
       CRT NUM('00012')                ;* 1 - leading zeroes are ok
       CRT NUM('-123334440.12')        ;* 1 - minus is ok...
       CRT NUM('123334440.12-')        ;* 0 - ...but not everywhere
       CRT NUM('+123334440.12')        ;* 1
       CRT NUM('6.02e23')              ;* 0 - E notation doesn't work
       CRT NUM('1233Q34440.12')        ;* 0 - of course it's not
       CRT NUM('2+2')                  ;* 0 - expression isn't evaluated
       CRT NUM('.00')                  ;* 1
