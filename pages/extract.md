# EXTRACT

The EXTRACT function is an alternative method of accessing values in
a dynamic array other than using the <n,n,n> syntax described earlier.

## COMMAND SYNTAX

    EXTRACT(expression1, expression2 {, expression3 {, expression4}})

## SYNTAX ELEMENTS

**expression1** specifies the dynamic array to work with and will
normally be a previously assigned variable.

The expressions 2 through 4 should all return a numeric value or a
runtime error will occur and the program will enter the debugger.

**expression2** specifies the field to extract, **expression3** the
value to extract and **expression4** the sub-value to extract.

## EXAMPLES

    array = "0"    ;    array<2> = "1"    ;    array<3> = "2"    ;    array<2,2> = 'Text'
    CRT DQUOTE( OCONV( EXTRACT(array, 2), 'MCP' ) )    ;*    "1]Text"
    CRT DQUOTE( EXTRACT(array, 2, 2) )                 ;*    "Text"
    CRT DQUOTE( EXTRACT(array, -1) )                   ;*    ""

This finction is useful when you need to take a part of a dynamic array in EVAL clause of
jQL statement (angle brackets notation won't work), e.g.:

<pre>
    LIST . SAMPLE 1 EVAL "(-12:@FM:5:@FM:-7)<2>" ID.SUPP
    &nbsp;
    Error in Statement "LIST . SAMPLE 1 EVAL "(-12:@FM:5:@FM:-7)<2>""
    Error in attribute definition item (-12:@FM:5:@FM:-7)<2>
    Error in Itype: expecting EOF, found '>'
    &nbsp;
    LIST . SAMPLE 1 EVAL "EXTRACT(-12:@FM:5:@FM:-7, 2)" ID.SUPP
    &nbsp;
    5</pre>
