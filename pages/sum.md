# SUM

SUM function sums numeric elements in a dynamic array.

## COMMAND SYNTAX

    SUM(expr)

## SYNTAX ELEMENTS

expr is a dynamic array.

## NOTES

Non-numeric sub-values, values and attributes are ignored.

## EXAMPLES

       V.ARRAY = 1 :@FM: 2 :@FM: 3.1
       CRT FMT( SUM(V.ARRAY), 'MCP' )         ;*  6.1
       V.ARRAY<4> = 6
       CRT FMT( SUM(V.ARRAY), 'MCP' )         ;*  12.1
       V.ARRAY<4,2> = 7
       CRT FMT( SUM(V.ARRAY), 'MCP' )         ;*  1^2^3.1^13
       V.ARRAY<4,3> = 'QWERTY'
       CRT FMT( SUM(V.ARRAY), 'MCP' )         ;*  still 1^2^3.1^13
       V.ARRAY<4,3,2> = 8
       CRT FMT( SUM(V.ARRAY), 'MCP' )         ;*  1^2^3.1^6]7]8
