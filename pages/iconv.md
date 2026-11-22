# ICONV

The ICONV function converts data in external form such as dates to
their internal form.

## COMMAND SYNTAX

    ICONV(expression1, expression2)

## SYNTAX ELEMENTS

**expression1** evaluates to the data upon which the conversion is
to be performed.

**expression2** should evaluate to the conversion code that is to be
performed against the data.

## NOTES

If the conversion code used assumes a numeric value and a non-numeric
value is passed then the original value in expression1 is returned
unless the emulation option iconv_nonnumeric_return_null is set.

## EXAMPLES

    * see internal date representation
       CRT ICONV('20121231', 'D')                            ;* 16437
    * calculate difference between dates
       CRT ICONV('20121231', 'D') - ICONV('20111231', 'D')   ;* 366
    * check if a year is a leap one
       CRT OCONV( ICONV('20111231', 'D4'), 'DJ' )    ;*  365
       CRT OCONV( ICONV('20121231', 'D4'), 'DJ' )    ;*  366

       CRT ICONV('00:01:02', 'MTS')        ;* 62
       CRT ICONV('4020412042', 'MX')       ;* @ A B
