# REGEXP

REGEXP function is a powerful function that allows pattern matching
using UNIX regular expressions. REGEXP is not supported on Windows.

## COMMAND SYNTAX

    REGEXP(variable, expression)

## SYNTAX ELEMENTS

**variable** can be any type of jBC variable and is the variable upon
which pattern matching will be performed.

**expression** should evaluate to a standard UNIX regular expression
as defined in the UNIX documentation.

## NOTES

The function returns a numeric integer value being the first character
in variable that matches the specified regular expression. If
a match is not found then the function returns 0. If the regular expression
was invalid then the function returns -1.

***A positive TAFJ note: REGEXP() function now works under Windows.***

## EXAMPLES

       String = "jBASE Software Inc."    ;* 4 (position of matching pattern -
       CRT REGEXP(String, 'S[^t]*')      ;*   "S" followed by "t" later on)
    * find an exact value in a list
       CRT REGEXP('051', '^(050|5001|051|053|265|4007|5007|037|060|098)$')   ;* 1
       CRT REGEXP('05123', '^(050|5001|051|053|265|4007|5007|037|060|098)$') ;* 0
    * everything in range "000" - "999" except "037"
       CRT REGEXP('036', '(0[0-24-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])')  ;* 1
       CRT REGEXP('037', '(0[0-24-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])')  ;* 0
       CRT REGEXP('137', '(0[0-24-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])')  ;* 1
    * everything in range "000" - "999" except "037" and "057"
       CRT REGEXP('036', '(0[0-246-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])') ;* 1
       CRT REGEXP('037', '(0[0-246-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])') ;* 0
       CRT REGEXP('057', '(0[0-246-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])') ;* 0
       CRT REGEXP('957', '(0[0-246-9][0-9]|0[0-9][0-68-9]|[1-9][0-9][0-9])') ;* 1
    * all 2-character country codes except "RS"
       CRT REGEXP('RS', '([A-QS-Z][A-Z]|[R][A-RT-Z])')                       ;* 0
       CRT REGEXP('AE', '([A-QS-Z][A-Z]|[R][A-RT-Z])')                       ;* 1
       CRT REGEXP('RU', '([A-QS-Z][A-Z]|[R][A-RT-Z])')                       ;* 1
    * negative lookahead assertion isn't supported ("all not containing 'bar'")
       CRT REGEXP('bar', '"^(?!.*?bar).*"')                                 ;* -1

***Another positive TAFJ note: negative lookahead now works.***
