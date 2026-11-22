# JQLGETPROPERTY

JQLGETPROPERTY is used to get the property of a compiled jQL statement

## COMMAND SYNTAX

    JQLGETPROPERTY(PropertyValue, Statement, Column, PropertyName)

## SYNTAX ELEMENTS

**PropertyValue** receives the requested property value from the system
or "" if the property is not set.

**Statement** is the result of a valid JQLCOMPILE(Statement).

**Column** specifies the column number for which the property value was
requested (otherwise 0 for the whole statement).

**PropertyName** are EQUATED values defined by INCLUDEing the file
JQLINTERFACE.h.

This function returns -1 if there is a problem with the parameters or
the programmer. These properties answer questions such as "Was LPTR
mode asked for" and "How many columns are there?"

## NOTES

Properties are valid after the compile; this is the main reason for
separating the compile and execute into two functions. After
compiling, it is possible to examine the properties and to set the
properties before executing.
