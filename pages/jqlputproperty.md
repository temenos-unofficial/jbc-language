# JQLPUTPROPERTY

JQLPUTPROPERTY sets a property in a compiled jQL statement.

## COMMAND SYNTAX

    JQLPUTPROPERTY(PropertyValue, Statement, Column, PropertyName)

## SYNTAX ELEMENTS

**PropertyValue** specifies the value to be set for the specified
property, such as one or "BLAH".

**Statement** is the result of a valid JQLCOMPILE() function.

**Column** holds 0 for a general property of the statement, or a
column number if the property is set for a specific column.

**PropertyName** are EQUATED values defined by INCLUDEing the file
JQLINTERFACE.h. There are lots of these and someone is going to have
to document each one.

This function returns -1 if it locates a problem in the statement
and 0 for no problem.

## NOTES

Some properties may require JQLEXECUTE()first.

Properties are valid after the compile; this is the main reason for
separating the compile and execute into two functions. After compiling,
it is possible to examine the properties and set properties before
executing.
