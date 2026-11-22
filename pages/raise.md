# RAISE

RAISE function raises system delimiters in a string to the next
highest delimiter.

## COMMAND SYNTAX

    RAISE(expression)

## SYNTAX ELEMENTS

The **expression** is a string containing one or more delimiters,
which are raised as follows:

| ASCII character  | Raised to       |
|------------------|-----------------|
| 248              | 249             |
| 249              | 250             |
| 250              | 251             |
| 251              | 252             |
| 252              | 253             |
| 253              | 254             |
| 254              | 255             |

## EXAMPLE

       V.ARRAY = 1 :@TM: 2 :@SM: 3 :@VM: 4
       CRT OCONV( V.ARRAY, 'MCP' )                      ;*  1.2\3]4
       CRT OCONV( RAISE(V.ARRAY), 'MCP' )               ;*  1\2]3^4

***TAFJ R23 note: not all characters are processed.***

       FOR i = 248 TO 254
           CRT i, SEQ( RAISE( CHAR(i) ) )
       NEXT i

Output under TAFJ:

    248     248
    249     249
    250     250
    251     252
    252     253
    253     254
    254     255
