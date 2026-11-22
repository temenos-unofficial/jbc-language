# PRECISION

PRECISION statement informs the number of digits of precision used after
the decimal point.

## COMMAND SYNTAX

    PRECISION integer

## NOTES

A PRECISION statement can be specified any number of times in a source file.
Only the most recently defined precision will be active at any one time.

Calling programs and external subroutines do not have to be compiled at the
same degree of precision, however, any changes to precision in a subroutine
will not persist when control returns to the calling program.

jBASE uses the maximum degree of precision allowed on the host machine in all
mathematical calculations to ensure maximum accuracy. It then uses the defined
precision to format the number.

## EXAMPLE

        PRECISION 6
        CRT 2 / 3

will print the value 0.666666 (note: truncation not rounding!).

## EXAMPLE 2

       var_1 = '0.123456789012345678901234567890123456789012345678901234567890'
       var_2 = '0.1234567890123456789012345678901234567890123456789012345678901'
       PRECISION 13
       GOSUB TEST                ;* 1
       PRECISION 17
       GOSUB TEST                ;* 0
       STOP
    TEST:
       var_3 = (var_1 = var_2)
       CRT var_3
       RETURN
    END
