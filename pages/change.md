# CHANGE

The CHANGE statement operates on a variable and replaces all
occurrences of one string with another.

## COMMAND SYNTAX

    CHANGE expression1 TO expression2 IN variable

## SYNTAX ELEMENTS

**expression1** - may evaluate to any result and is the string of
characters that will be replaced.

**expression2** - may also evaluate to any result and is the string
of characters that will replace

**expression1** - The variable may be any previously assigned variable
in the program.

## NOTES

There is no requirement that strings be of the same length. The jBC
language also supports the CHANGE function for compatibility with
older systems.

## EXAMPLE

       V.STRING = 'ABCDEFCDYZ'
       CHANGE 'C' TO 'Q' IN V.STRING
       CRT V.STRING                 ;* ABQDEFQDYZ
       CHANGE 'QD' TO 'nnn' IN V.STRING
       CRT V.STRING                 ;* ABnnnEFnnnYZ
    * Both types of arrays are OK as well (dynamic ones can be processed in one go)
       V.ARRAY = V.STRING
       V.ARRAY<2> = V.STRING
       CHANGE 'nnn' TO 'mmm' IN V.ARRAY
       CRT OCONV(V.ARRAY, 'MCP')    ;* ABmmmEFmmmYZ^ABmmmEFmmmYZ
       DIM V.DIM.ARR(3)
       MAT V.DIM.ARR = V.STRING
       CHANGE 'nnn' TO 'mmm' IN V.DIM.ARR(2)
       CRT V.DIM.ARR(2)             ;* ABmmmEFmmmYZ
    * Funny but numbers can also be processed
       V.NUM = 12345.67
       CHANGE 3 TO 9 IN V.NUM
       CRT V.NUM                    ;* 12945.67
    * Compatibility mode
       V.STRING = CHANGE(V.STRING, 'YZ', '+-')
       CRT V.STRING                 ;* ABnnnEFnnn+-
