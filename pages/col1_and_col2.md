# COL1 and COL2

Use these functions in conjunction with the FIELD function to determine
the character positions 1 position before and 1 position after the
location of the last field.

## COMMAND SYNTAX

    COL1() / COL2()

## NOTES

When a field has been located in a string, it is sometimes useful to
know its exact position within the string to manipulate either it, or
the rest of the string. COL1() will return the position of the
character immediately before the last field located. COL2() will return
the position of the character immediately after the end of the last
field located. Use them to manipulate the string.

## EXAMPLE

      V.STRING = 'ABC/DEF/QWE/XYZ'
    * One field
       CRT FIELD(V.STRING, '/', 2)         ;* DEF
       CRT COL1()                          ;* 4 - position right before "DEF"
       CRT COL2()                          ;* 8 - position right after it
    * Alternate way
       CRT V.STRING['/', 2, 1]   ;* DEF
    * More than one field
       CRT FIELD(V.STRING, '/', 2, 2)      ;* DEF/QWE
       CRT COL1()                          ;* 4
       CRT COL2()                          ;* 12
