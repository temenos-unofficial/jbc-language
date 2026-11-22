# LOWER

This function lowers system delimiters in a string to the next lowest
delimiter.

## COMMAND SYNTAX

    LOWER(expression)

## SYNTAX ELEMENTS

**expression** is a string containing one or more delimiters, lowered as
follows:

| ASCII character  | Lowered to      |
|------------------|-----------------|
| 255              | 254             |
| 254              | 253             |
| 253              | 252             |
| 252              | 251             |
| 251              | 250             |
| 250              | 249             |
| 249              | 248             |

## EXAMPLE

       V.ARRAY = 1 :@FM: 2 :@FM: 3 :@FM: 4
       CRT OCONV(V.ARRAY, 'MCP')                      ;*  1^2^3^4
       CRT OCONV( LOWER(V.ARRAY), 'MCP' )             ;*  1]2]3]4

***TAFJ R23 note: in 3 cases results are wrong.***

       FOR i = 249 TO 255
           CRT i, SEQ( LOWER( CHAR(i) ) )
       NEXT i

Output:

    249     249
    250     250
    251     63738
    252     251
    253     252
    254     253
    255     254
