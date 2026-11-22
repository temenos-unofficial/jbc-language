# TRIM

TRIM statement allows characters to be removed from a string in a
number of ways.

## COMMAND SYNTAX

    TRIM(expression1 {, expression2{, expression3}})

## SYNTAX ELEMENTS

**expression1** specifies the string from which to trim characters.

**expression2** may optionally specify the character to remove from
the string. If not specified then the space character is assumed.

**expression3** evaluates to a single character specifies the type
of trim to perform.

## NOTES

The trim types available for expression3 are:

|Type | Operation                                               |
|-----|---------------------------------------------------------|
|L    | removes leading characters only                         |
|T    | removes trailing characters only                        |
|B    | removes leading and trailing characters                 |
|A    | removes all occurrences of the character                |
|R    | removes leading, trailing and redundant characters      |
|F    | removes leading spaces and tabs                         |
|E    | removes trailing spaces and tabs                        |
|D    | removes leading, trailing and redundant spaces and tabs.|

## EXAMPLES

       V.STRING = '   A   string  '
    * Get rid of leading spaces
       CRT '"' : TRIM(V.STRING, ' ', 'L') : '"'   ;*    "A   string  "
    * Get rid of trailing spaces
       CRT '"' : TRIM(V.STRING, ' ', 'T') : '"'   ;*    "   A   string"
    * Get rid of leading and trailing spaces
       CRT '"' : TRIM(V.STRING, ' ', 'B') : '"'   ;*    "A   string"
    * Get rid of leading, trailing and redundant spaces
       CRT '"' : TRIM(V.STRING, ' ', 'R') : '"'   ;*    "A string"
    * Get rid of leading zeroes
       CRT '"' : TRIM('000033', '0', 'L') : '"'   ;*    "33"
