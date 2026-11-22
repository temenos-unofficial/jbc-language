# REMOVE

REMOVE will successively extract delimited strings from a dynamic
array.

## COMMAND SYNTAX

    REMOVE variable FROM array SETTING setvar

## SYNTAX ELEMENTS

**variable** is the variable, which is to receive the extracted string.

**array** is the dynamic array from which the string is to be extracted.

**setvar** is set by the system during the extraction to indicate the
type of delimiter found:

|Code|  Description       | Notes           |
|----|--------------------|-----------------|
|0   |  end of the array  |                 |
|1   |  xFF ASCII 255     |                 |
|2   |  xFE ASCII 254     | Field marker    |
|3   |  xFD ASCII 253     | Value marker    |
|4   |  xFC ASCII 252     | Subvalue marker |
|5   |  xFB ASCII 251     |                 |
|6   |  xFA ASCII 250     |                 |

## NOTES

The first time the REMOVE statement is used with a particular array,
it will extract the first delimited string it and set the special
"remove pointer" to the start of the next string (if any). The next
time REMOVE is used on the same array, the pointer will be used to
retrieve the next string and so on. The array is not altered.

The variable named in the SETTING clause is used to record the type of
delimiter that was found - so that you can tell whether the REMOVE
statement
 extracted a field, a value or a subvalue for example. Delimiters are
defined as characters between xF9 and xFF only. Once the end of the
array has been reached, the string variable will not be updated and
the SETTING clause will always return 0. You can reset the "remove
pointer" by assigning the variable to itself - for example REC = REC.

## EXAMPLE

       REC = "Field 1" :@FM: "Field 2" :@SM: " Sub-value" :@VM: "Value"
       REMOVE EXSTRING FROM REC SETTING V.STATUS  ; CRT V.STATUS         ;*  2
       REMOVE EXSTRING FROM REC SETTING V.STATUS  ; CRT V.STATUS         ;*  4
       REMOVE EXSTRING FROM REC SETTING V.STATUS  ; CRT V.STATUS         ;*  3
       REMOVE EXSTRING FROM REC SETTING V.STATUS  ; CRT V.STATUS         ;*  0
       REC = REC                   ;* reset "remove pointer"
       REMOVE EXSTRING FROM REC SETTING V.STATUS  ; CRT V.STATUS         ;*  2
