# FMT

Format data according to mask definition.

## INTERNATIONAL MODE

When using the FMT function in International Mode the "Width" fields
refer to character display widths, such that a character may take up
more than a single display position. This is typical of the Japanese,
Chinese, and characters whereby the character display requires
possibly two display positions.

Additional date formatting codes have been provided for use in
Internationalized programs.

See also: [OCONV](https://jbc-lang.org/pages/oconv.md) for date/time/numeric masks and [FMTS](https://jbc-lang.org/pages/fmts.md).

|Mask Code|	                             Description                       |
|---------|----------------------------------------------------------------|
|j        | Justification                                                  |
|         |                                                                |
|         |   R:  Right Justified                                          |
|         |   L:  Left Justified                                           |
|         |   U:  Left Justified, Break on space. Note: This justification |
|         |        will format the output into blocks of data in the       |
|         |        variable and it is up to the programmer to actually     |
|         |        separate the blocks.	                                   |
|         |   D:  Date (OCONV)                                             |
|         |   M:  Time (OCONV)                                             |
|         |                                                                |
|n        | Decimal Precision: A number from 0 to 9 that defines the       |
|         | decimal precision. It specifies the number of digits for       |
|         | output following the decimal point. The processor inserts      |
|         | trailing zeros if necessary. If n is omitted or is 0, a decimal|
|         | point will not be output.                                      |
|         |                                                                |
|m        | Scaling Factor: A number that defines the scaling factor. The  |
|         | source value is descaled (divided) by that power of 10. For    |
|         | example, if m=1, the value is divided by 10; if m=2, the value |
|         | is divided by 100, and so on. If m is omitted, it is assumed   |
|         | equal to n (the decimal precision).                            |
|         |                                                                |
|Z        | Suppress leading zeros. NOTE: fractional values, which have no |
|         | integer, will have a zero before the decimal point. If the     |
|         | value is zero, a null will be output.                          |
|         |                                                                |
|,        | The thousands separator symbol. It specifies insertion of      |
|         | thousands separators every three digits to the left of the     |
|         | decimal point. You can change the display separator symbol by  |
|         | invoking the SET-THOU command. Use the SET-DEC command to      |
|         | specify the decimal separator.                                 |
|         |                                                                |
|c        | Credit Indicator. NOTE: If a value is negative and you have not|
|         | specified one of these indicators, the value will be displayed |
|         | with a leading minus sign. If you specify a credit indicator,  |
|         | the data will be output with either the credit characters or an|
|         | equivalent number of spaces, depending on its value.           |
|         |                                                                |
|         |  C:     Prints the literal CR after negative values.           |
|         |  D:     Prints the literal DB after positive values.           |
|         |  E:     Encloses negative values in angle brackets < >         |
|         |  M:     Prints a minus sign after negative values.             |
|         |  N:     Suppresses embedded minus sign.                        |
|         |                                                                |
|$        |  Appends a Dollar sign to value.                               |
|         |                                                                |
|         |  Fill Character and Length                                     |
|         |                                                                |
|         |  #n:   Spaces. Repeat space n times. Output value is overlaid  |
|         |        on the spaces created.                                  |
|         |   n:   Asterisk. Repeat asterisk n times. Output value is      |
|         |        overlaid on the asterisks created.                      |
|         |  %n:   Zero. Repeat zeros n times. Output value is overlaid on |
|         |        the zeros created.                                      |
|         |  &x:   Format. x can be any of the above format codes, a       |
|         |        currency symbol, a space, or literal text. The first    |
|         |        character following & is used as the default fill       |
|         |        character to replace #n fields without data. Format     |
|         |        strings are enclosed in parentheses "()".               |

## EXAMPLES

       X = 1234.56
       CRT DQUOTE( FMT(X, 'R2#10') )           ;*  "   1234.56"
       CRT FMT(X, 'L2%10')                     ;*  1234.56000
       CRT FMT(X, 'R2%10')                     ;*  0001234.56
       CRT FMT(X, 'L2*10')                     ;*  1234.56***
       CRT FMT(X, 'R2*10')                     ;*  ***1234.56
       X = 123456.78
       CRT DQUOTE( FMT(X, 'R2,$#15') )         ;*  "    $123,456.78"
       CRT DQUOTE( FMT(X, 'R2,&$#15') )        ;*  "     123,456.78"
       CRT DQUOTE( FMT(X, 'R2,& $#15') )       ;*  "    $123,456.78"
       X = -123456.78
       CRT DQUOTE( FMT(X, 'R2,C&*$#15') )      ;*  "  $123,456.78CR"
       X = 1234567890
       CRT FMT(X, 'R((###) ###-###)')          ;*  (234) 567-890
       CRT FMT(X, 'R((#3) #2-#4)')             ;*  (234) 56-7890
       X = 16376
       CRT FMT(X, 'D4/')                       ;*  10/31/2012
       CRT FMT(X, 'DY')                        ;*  2012
       CRT FMT(X, 'DY2')                       ;*  12
       CRT FMT(X, 'D2')                        ;*  31 OCT 12
       CRT FMT(X, 'DQ')                        ;*  4 (quarter)
       CRT FMT(X, 'DD')                        ;*  31
       CRT FMT(X, 'DM')                        ;*  10
       CRT FMT(X, 'DMA')                       ;*  OCTOBER
       CRT FMT(X, 'DJ')                        ;* 305 - number of a day in the year
       CRT FMT(X, 'DW')                        ;* 3 - number of a day in the week
       CRT FMT(X, 'DWA')                       ;* WEDNESDAY
       CRT FMT(TIME(), 'MT')                   ;* e.g. 21:25
       CRT FMT(TIME(), 'MTS')                  ;* e.g. 21:25:30
       X = 'A LONG STRING TO BE SPLIT'
       CRT FMT(X, '10L')                       ;* A LONG STR.ING TO BE .SPLIT
       X = 'ABCDEF'
       CRT FMT(X, 'MX')                        ;* 414243444546
       CRT FMT(@FM, 'MX')                      ;* FE

***TAFJ note: examples that work incorrectly:***

       CRT FMT(74952223355, 'R(+# (#3) #3-#2-#2)')
       * output: (+ 495) 222-33-55, expected +7 (495) 222-33-55

       $INSERT I_F.SPF
       OPEN 'F.SPF' TO f_spf ELSE CRT 'SPF open error'  ;  RETURN
       READ r_spf FROM f_spf, 'SYSTEM' ELSE CRT 'SPF read error'  ;  RETURN
       date_time = r_spf<Spf_DateTime>
       CRT FMT('20' : date_time, '####-##-##_##:##')  ;* output: 2022-03-24_11:0  (last digit missing)
