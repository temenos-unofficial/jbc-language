# INMAT

The INMAT() function returns the number of dimensioned array elements.

## COMMAND SYNTAX

    INMAT( {array} )

DESCRIPTION

Using the INMAT() function, without the 'array' argument, returns the
number of dimensioned array elements from the most recent
[MATREAD](https://jbc-lang.org/pages/matread.md), [MATREADU](https://jbc-lang.org/pages/matreadu.md), MATREADL or
[MATPARSE](https://jbc-lang.org/pages/matparse.md) statement. If the number of array elements exceeds
the number of elements specified in the corresponding [DIMENSION](https://jbc-lang.org/pages/dimension.md)
statement, the INMAT() function will return zero.

Using the INMAT(), function with the 'array' argument, returns the
current number of elements to the dimensioned 'array'.

## NOTES

In some dialects the INMAT() function is also used to return the modulo
of a file after the execution of an OPEN statement, which is
inconsistent with its primary purpose and not implemented in jBASE. To
achieve this functionality use the [IOCTL](https://jbc-lang.org/pages/ioctl.md) function with the
JIOCTL_COMMAND_FILESTATUS command.

## EXAMPLES

       DIM cust_rec(99)
       MAT cust_rec = ''
       CRT INMAT(cust_rec)                  ;* 99
       DIM cust_rec(299)
       cust_rec(150) = 'Y'
       CRT INMAT(cust_rec)                  ;* 299
       CRT INMAT()                          ;* 0
       *
       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO f_temp ELSE ABORT 201, 'F.TEMP'
       new_rec = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE new_rec TO f_temp, 'REC1'
       *
       MAT cust_rec = ''
       MATREAD cust_rec FROM f_temp, 'REC1' ELSE
          CRT 'Read error'
          STOP
       END
       CRT INMAT(cust_rec)                  ;* 299 - current size
       CRT INMAT()                          ;* 3
       *
       dyn_array = 1 :@FM: 2 :@VM: 3 :@SM: 4: @FM: 5 :@FM: 6
       MATPARSE cust_rec FROM dyn_array
       CRT INMAT()                          ;* 4 (only FMs count)
       CRT FMT(cust_rec(2), 'MCP')          ;* 2]3\4
       DIM cust_rec(100,2)
       CRT FMT( INMAT(cust_rec), 'MCP' )      ;* 100]2
