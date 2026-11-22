# SORT

The SORT function sorts all elements of a dynamic array in ascending
left-justified order.

## COMMAND SYNTAX

    SORT(expression)

## SYNTAX ELEMENTS

**expression** may evaluate to any data type but will only be useful if
it evaluates to a dynamic array.

## NOTES

The dynamic array can contain any number and combination of system
delimiters.

The SORT function will return an attribute-delimited array of the
sorted elements.

All system delimiters in expression will be converted to an attribute
mark '0xFE' in the sorted result. For example, the following code

    MyArray = 'GEORGE':@VM:'FRED':@AM:'JOHN':@SM:'ANDY'
    CRT OCONV( SORT(MyArray), 'MCP')

will display:

<pre>
    ANDY^FRED^GEORGE^JOHN</pre>

MyArray remains unchanged.

The SORT is achieved by the quick sort algorithm, which sorts in situ
and is very fast.

## INTERNATIONAL MODE

When using the SORT function in International Mode, the function will
use the currently configured locale to determine the rules by which
each string is considered less than or greater than the other for
sort purposes.
