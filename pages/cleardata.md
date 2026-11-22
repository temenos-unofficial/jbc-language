# CLEARDATA

The CLEARDATA statement clears data stacked by the DATA statement.

## COMMAND SYNTAX

    CLEARDATA

## SYNTAX ELEMENTS

None

## EXAMPLE

    * SYSTEM(14) returns the number of characters available in input buffer
       CRT SYSTEM(14)        ;*  0
       DATA '123'
       DATA '456'
       CRT SYSTEM(14)        ;*  8 (including 2 line end characters)
       CLEARDATA
       CRT SYSTEM(14)        ;*  0
