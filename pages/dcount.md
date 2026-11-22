# DCOUNT

The DCOUNT() function counts the number of field elements in a string
that are separated by a specified delimiter.

## COMMAND SYNTAX

    DCOUNT(expression1, expression2)

## SYNTAX ELEMENTS

**expression1** evaluates to a string in which fields are to be
counted.

**expression2** evaluates to the delimiter string used to count the
fields.

## NOTES

The delimiter string may consist of more than one character.

If expression1 is a NULL string, the function returns a value of zero.

The delimiter string may consist of any character, including system
delimiters such as field marks or value marks.

See also: [COUNT](https://jbc-lang.org/pages/count.md)

## EXAMPLES

       search_string = "A:B:C:D"
       CRT DCOUNT(search_string, ':')             ;* 4
       CRT COUNT(search_string, ':')              ;* 3 - COUNT returned
                                                  ;* number of ":" symbols
       CHANGE ':' TO '->' IN search_string
       CRT search_string                          ;* A->B->C->D
       CRT DCOUNT(search_string, '->')            ;* 4
