# FIELD

The FIELD function returns a multi-character delimited field from
within a string.

## COMMAND SYNTAX

    FIELD(string, delimiter, occurrence{, extractCount})

## SYNTAX ELEMENTS

**string** specifies the string, from which the field(s) is to be
extracted.

**delimiter** specifies the character or characters that delimit
the fields within the dynamic array.

**occurrence** should evaluate to an integer of value 1 or higher.
It specifies the delimiter used as the starting point for the
extraction.

**extractCount** is an integer that specifies the number of fields
to extract. If omitted, assumes one.

## NOTES

If the emulation option, jbase_field, is set then the field delimiter
may consist of more than a single character, allowing fields to be
delimited by complex codes.

See also: [GROUP](https://jbc-lang.org/pages/group.md)

## EXAMPLES

       V.STRING = 'ABC/DEF/QWE/XYZ'
    * One field
       CRT FIELD(V.STRING, '/', 2)         ;* DEF
    * Alternate way
       CRT V.STRING['/', 2, 1]             ;* DEF
    * More than one field
       CRT FIELD(V.STRING, '/', 2, 2)      ;* DEF/QWE
       CRT V.STRING['/', 2, 3]             ;* DEF/QWE/XYZ
       CRT DQUOTE( FIELD(V.STRING, '/', 2, 99) )    ;* take "all the rest after 1st"
