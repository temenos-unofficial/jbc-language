# MATCHES

MATCH or MATCHES clause applies pattern matching to an expression.

## COMMAND SYNTAX

    expression1 MATCHES expression2

## SYNTAX ELEMENTS

**expression1** may evaluate to any type. **expression2** should
evaluate to a valid pattern matching string as described below.

**expression1** is then matched to the pattern supplied and a value of
Boolean TRUE is returned if the pattern is matched. A value of Boolean
FALSE is returned if the pattern is not matched.

**expression2** can contain any number of patterns to match those
separated by value marks. The value mark implies a logical OR of the
specified patterns and the match will evaluate to Boolean TRUE if
expression1 matches any of the specified patterns.

## INTERNATIONAL MODE

When using the MATCHES statement in International Mode, the statement
will use the currently configured locale to determine the properties
according to the Unicode Standard for each character in the expression.
i.e., is the character alpha or numeric?

## NOTES

The rule table shown below shows construction of pattern matching
strings (n refers to any integer number).

| Pattern          | Explanation                                   |
|------------------|-----------------------------------------------|
| nN               | Matches a sequence of n digits                |
| nA               | Matches a sequence of n alpha characters      |
| nC               | Matches a sequence of n alpha characters      |
|                  | or digits                                     |
| nX               | Matches a sequence of any characters          |
| "string"         | Matches the character sequence string exactly |

Applies the pattern to all characters in expression1 and it must match
all characters in the expression to evaluate as Boolean TRUE.

Specify the integer value 'n' as '0'. This will cause the pattern to
match any number of characters of the specified type.

## EXAMPLES

    * T24 IDs matching
        transfer_id = 'FT130172HQJ4'
        CRT transfer_id MATCHES "'FT'5N5X"           ;*  1
        hist_id = 'FT130172HQJ4;1'
        CRT hist_id MATCHES "'FT'5N5X"               ;*  0
        CRT hist_id MATCHES "'FT'5N5X;1N"            ;*  1
    * date
        start_date = '2011-10-25'
        CRT start_date MATCHES "4N'-'2N'-'2N"        ;*  1
    * a fresh example: dash can be used to indicate "from"-"to" pattern:
        start_date = '2022/08/31'
        start_date_short = '22/08/31'
        CRT start_date MATCHES "2-4N'/'2N'/'2N"               ;* 1
        CRT start_date_short MATCHES "2-4N'/'2N'/'2N"         ;* 1
    * emulations compatibility
        cust_name = 'JOHN DORY'
        CRT cust_name MATCH "JOHN..."            ;*  1 under prime, 0 under jbase
        CRT cust_name MATCH "'JOHN'..."          ;*  1 under prime, 0 under jbase
        CRT cust_name MATCH "'JOHN'0X"           ;*  1 under both
        CRT cust_name MATCH "'John'..."          ;*  0 under both
    * "C" - alphanumeric - isn't supported at all under prime
        CRT '2HQJ4' MATCHES "5C"                 ;* 1 under jbase emulation
    * numbers
        CRT 9.99 MATCHES "0N'.'2N"               ;* 1
        CRT '.99' MATCHES "0N'.'2N"              ;* 1
    * avoid messing up data with patterns (example for prime):
        cust_address = '3RD FLOOR, 17A ELM STREET'
        CRT cust_address MATCH "...17A..."   ;* 0 - 17A means 17 alpha characters
        CRT cust_address MATCH "...'17A'..." ;* 1 - here '17A' is a string to search
