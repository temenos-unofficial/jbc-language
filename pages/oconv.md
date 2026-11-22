# OCONV

OCONV statement converts internal representations of data to their
external form.

## COMMAND SYNTAX

    OCONV(expression1, expression2)

## SYNTAX ELEMENTS

**expression1** may evaluate to any data type but must be relevant to
the conversion code.

**expression2** should evaluate to a conversion code from the list
below. Alternatively, expression2 may evaluate to a user exit known
to the jBC language or supplied by the user.

## INTERNATIONAL MODE

Description of date, time, number and currency conversions when
used in ICONV and International Mode

## NOTES

OCONV will return the result of the conversion of expression1 by
expression2. Shown below are valid conversion codes:

|Conversion   |     Action                                               |
|-------------|----------------------------------------------------------|
|D{n{c}}      |   Converts an internal date to an external date format.  |
|             |   The numeric argument n specifies the field width       |
|             |   allowed for the year and can be 0 to 4 (default 4).    |
|             |   The character 'c' causes the date to be return in the  |
|             |   form ddcmmcyyyy. If it is not specified then the month |
|             |   name is returned in abbreviated form.                  |
|DI           |   Allows the conversion of an external date to the       |
|             |   internal format even though an output conversion       |
|             |   is expected.                                           |
|DD           |   Returns the day in the current month.                  |
|DM           |   Returns the number of the month in the year.           |
|DMA          |   Returns the name of the current month.                 |
|DJ           |   Returns the number of the day in the year (0-366).     |
|DQ           |   Returns the quarter of the year as a number 1 to 4.    |
|DW           |   Returns the day of the week as a number 1 to 7         |
|             |   (Monday is 1).                                         |
|DWA          |   Returns the name of the day of the week.               |
|DY{n}        |   Returns the year in a field of n characters.           |
|F            |   Given a prospective filename for a command such as     |
|             |   CREATE-FILE this conversion will return a filename     |
|             |   that is acceptable to the version of UNIX TAFC is      |
|             |    running on.                                           |
|MCA          |   Removes all but alphabetic characters from the input   |
|             |   string.                                                |
|MC/A         |   Removes all but the NON-alphabetic characters in the   |
|             |   input string.                                          |
|MCN          |   Removes all but numeric characters in the input string.|
|MC/N         |   Removes all but NON numeric characters in the input    |
|             |   string.                                                |
|MCB          |   Returns just the alphabetic and numeric characters from|
|             |   the input string.                                      |
|MC/B         |   Removes the alphabetic and numeric characters from     |
|             |   their input string.                                    |
|MCC;s1;s2    |   Replaces all occurrences of string s1 with string s2.  |
|MCL          |   Converts all upper case characters in the string to    |
|             |   lower case characters.                                 |
|MCU          |   Converts all lower case characters in the string to    |
|             |   upper case characters.                                 |
|MCT          |   Capitalizes each word in the input string; e.g. JIM    |
|             |   converts to Jim.                                       |
|MCP{c}       |   Converts all non-printable characters to a period      |
|             |   character "." in the input string. When supplied use   |
|             |   the character                                          |
|             |   "c" in place of the period.                            |
|MCPN{n}      |   In the same manner as the MCP conversion, it replaces  |
|             |   all non-printable characters. The ASCII hexadecimal    |
|             |   value                                                  |
|             |   follows the replacing character.                       |
|MCNP{n}      |   Performs the opposite conversion to MCPN. The ASCII    |
|             |   hexadecimal value following the tilde character        |
|             |   converts to its                                        |
|             |   original binary character value.                       |
|MCDX         |   Converts the decimal value in the input string to its  |
|             |   hexadecimal equivalent.                                |
|MCXD         |   Converts the hexadecimal value in the input string to  |
|             |   its decimal equivalent.                                |
|Gncx         |   Extracts x groups separated by character c skipping n  |
|             |   groups, from the input string.                         |
|MT{HS}       |   Performs time conversions.                             |
|MD           |   Converts the supplied integer value to a decimal value.|
|MP           |   Converts a packed decimal number to an integer value.  |
|MX           |   Converts ASCII input to hexadecimal characters.        |
|T            |   Performs file translations given a cross-reference     |
|             |   table in a record in a file.                           |

## EXAMPLES

Date and time:

       CRT OCONV(1, 'D')         ;* 01 JAN 1968
       CRT OCONV( DATE(), 'D' )    ;* here and below output for 30 MAY 2013
       CRT OCONV( DATE(), 'D2' )   ;* 30 MAY 13
       CRT OCONV( DATE(), 'D4/' )  ;* 05/30/2013
       CRT OCONV( DATE(), 'DY' )   ;* 2013
       CRT OCONV( DATE(), 'DY2' )  ;* 13
       CRT OCONV( DATE(), 'DQ' )   ;* 2 (quarter)
       CRT OCONV( DATE(), 'DM' )   ;* 5 (month number)
       CRT OCONV( DATE(), 'DMA' )  ;* MAY
       CRT OCONV( DATE(), 'DD' )   ;* 30
       CRT OCONV( DATE(), 'DJ' )   ;* 150 (number of a day in the year)
       CRT OCONV( DATE(), 'DW' )   ;* 4 (day number in a week, starting from Monday)
       CRT OCONV( DATE(), 'DWA' )  ;* THURSDAY
       CRT OCONV( TIME(), 'MT' )   ;* 20:04
       CRT OCONV( TIME(), 'MTS' )  ;* 20:04:08
       CRT OCONV(1, 'MTS')       ;* 00:00:01
    * difference of 2 dates (in days)
       CRT ICONV('20121231', 'D') - ICONV('20111231', 'D')   ;* 366
    * Check if a year is a leap one
       CRT OCONV( ICONV('20131231', 'D4'), 'DJ' )    ;*  365
       CRT OCONV( ICONV('20161231', 'D4'), 'DJ' )    ;*  366

Strings:

    * split a string
       the_string = 'LONG STRING TO BE SPLIT'
       the_split = FMT(the_string, '10L')
       CRT OCONV(the_split, 'MCP')         ;* LONG STRIN.G TO BE SP.LIT
    * hexadecimal output
       CRT OCONV(the_split, 'MX')
    * Output:
    * 4C4F4E4720535452494EFB4720544F204245205350FB4C495420202020202020
    *
    * Remove non-alphabetic symbols:
       CRT OCONV(the_split, 'MCA')     ;* LONGSTRINGTOBESPLIT
    * Remove all alphabetic symbols:
       CRT OCONV( OCONV(the_split, 'MC/A'), 'MX' )  ;* 20FB202020FB20202020202020
    * Note FB symbols in the output above.. see what's that
       CRT OCONV('FB', 'MCXD')    ;* 251 a.k.a. @TM
       CHANGE @TM TO '->' IN the_split ; CRT the_split ;* LONG STRIN->G TO BE SP->LIT
    * Remove non-numeric symbols:
       CRT OCONV('another 1 bites the dust', 'MCN')    ;* 1
    * Remove all numeric symbols:
       CRT OCONV('another 1 bites the dust', 'MC/N')   ;* another  bites the dust
    * formatting
       CRT SQUOTE( FMT(the_string, '30L') )    ;* 'LONG STRING TO BE SPLIT       '
       CRT SQUOTE( FMT(the_string, '30R') )    ;* '       LONG STRING TO BE SPLIT'
    * replace some data
       CRT OCONV(the_string, 'MCC;STRING;DATA')  ;* LONG DATA TO BE SPLIT
    * change case
       CRT OCONV(the_string, 'MCL')  ;* long string to be split
       CRT OCONV('do it', 'MCU')     ;* DO IT
       CRT OCONV(the_string, 'MCT')  ;* Long String To Be Split
    * extract delimited fields: skip 1 space-delimited word, take 3 from that point
       CRT OCONV(the_string, 'G1 3')  ;* STRING TO BE

Numbers:

    * amounts
       amount_fcy = 1234
       CRT FMT(amount_fcy, 'R%7')   ;*       0001234
       amount_fcy += 0.56
       CRT FMT(amount_fcy, 'R2*19')              ;*  ************1234.56
       CRT SQUOTE( FMT(amount_fcy, 'L2,#19') )     ;*  '1,234.56           '
       CRT FMT(-amount_fcy, 'R2,C&*$#15')        ;*           $1,234.56CR
       CRT FMT(amount_fcy,'L0')                  ;* 1235
    * phone numbers
       CRT FMT(1234567890, 'R((###) ###-###)')       ;* (234) 567-890
       CRT FMT(74952223355, 'R(+# (#3) #3-#2-#2)')   ;* +7 (495) 222-33-55
    * FMT() and OCONV() are often interchangeable;
    * though it's not the case for next 2 lines...
       CRT DQUOTE( FMT(123456.78, 'R2,$#15') )           ;*  "    $123,456.78"
       CRT DQUOTE( OCONV(123456.78, 'R2,$#15') )         ;*  Error in Range Test

User exits:

       CRT OCONV("", "U50BB")        ;* port number and user name
       HUSH ON
       EXECUTE 'SELECT .'
       HUSH OFF
       CRT OCONV("", "U30E0")        ;* number of items in active SELECT list
    * sleep
       start_time = TIME()  ;  dummy = OCONV(3, "U307A")
       CRT TIME() - start_time        ;* 3
    * reverse a string
       CRT OCONV('desrever saw gnirtS', "U51AA")
    * remove duplicate consecutive characters
       CRT OCONV('hhahhahh', "U31AC")        ;* haha

***TAFJ note: user exits "U50BB", "U30E0" and "U51AA" were tested under TAFJ; none of them works.***

***TAFJ note 2: example that returns FE under TAFC and EFA3BE under TAFJ:***

       OCONV(@FM, 'MX')

See also: [FMT](https://jbc-lang.org/pages/fmt.md) function.
