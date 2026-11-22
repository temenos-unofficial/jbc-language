# TRANS

TRANS function returns the data value of a field, given the name
of the file, the record key, the field number, and an action code.

## COMMAND SYNTAX

    TRANS([ DICT ] filename, key, field#, action.code)

## SYNTAX ELEMENTS

**DICT** is the literal string to be placed before the file name in
the event it is desired to open the dictionary portion of the file,
rather than the data portion.

**filename** is a string containing the name of the file to be
accessed.  Note that it is the actual name of the file, and not a
file unit variable.  This function requires the file name, regardless
of whether or not the file has been opened to a file unit variable.

**key** is an expression that evaluates to the record key, or item ID,
of the record from which data is to be accessed.

**field#** is the field number to be retrieved from the record.

**action.code** indicates what should happen if the field is null, or
the if record is not found.  This is a literal.  The valid codes are:

| Code | Description                                          |
|------|------------------------------------------------------|
|X     | Returns a null string. This is the default action    |
|V     | Prints an error message.                             |
|C     | Returns the value of key.                            |

## NOTES

If the field being accessed is a dynamic array, TRANS will return the
array with the delimiter characters lowered by 1.   For example,
multivalue marks (ASCII-253) are returned as subvalue marks (ASCII-252),
and subvalue marks are returned as text marks (ASCII-251).

If you supply -1 for field#, the entire record will be returned.

The TRANS function is the same as the [XLATE](https://jbc-lang.org/pages/xlate.md) function.

## EXAMPLES

Retrieval of a simple field:  Given a file called "VENDORS" containing a
record with the record key of "12345" and which contains the value of
"ABC Company" in field 1,

    VENDOR.ID = "12345"
    VENDOR.NAME = TRANS('VENDORS', VENDOR.ID, 1 , 'X')
    CRT VENDOR.NAME

will display: ABC Company

Retrieval of an array:  Suppose field 6 of the VENDORS file contains a
multivalued list of purchase order numbers, such as:

<pre>
    10011]10062]10079</pre>

use the TRANS function to retrieve it:

    PO.LIST = TRANS('VENDORS', VENDOR.ID, 6, 'X')
    CRT PO.LIST

will display: 10011\10062\10079

Notice that the backslashes (\) were substituted for brackets (]),
indicating that the delimiter is now CHAR(252).

Retrieval of an entire dictionary item: Given a dictionary item
called "VENDOR.NAME" with the following content:

<pre>
    001 A
    002 1
    003 Vendor Name
    004
    005
    006
    007
    008
    009 L
    010 30</pre>

these statements

    DIC.ID = "VENDOR.NAME"
    DIC.REC = TRANS('DICT VENDORS', DIC.ID, -1, 'C')
    PRINT DIC.REC

will display

<pre>
    A]1]Vendor Name]]]]]L]30</pre>

***TAFJ note: TRANS() function returns record @ID instead of field contents. Example (on Temenos Model Bank):***

       CRT TRANS('F.COMPANY', 'EU0010001', 2, 'X')
       * expected output: Model Bank - Europe
       * output: EU0010001
       * workaround: use XLATE

***TAFJ R22 note: fixed.***
