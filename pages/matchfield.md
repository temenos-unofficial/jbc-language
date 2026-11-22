# MATCHFIELD

This function is used to check a string against a match pattern.

## COMMAND SYNTAX

    MATCHFIELD(string, pattern, field)

## SYNTAX ELEMENTS

**field** is an expression that evaluates to the portion of the
match string to be returned.

If string matches pattern, the MATCHFIELD function returns the
portion of string that matches the specified field in pattern.
If string does not match pattern, or if string or pattern evaluates
to the null value, the MATCHFIELD function returns an empty string.
If field evaluates to the null value, the MATCHFIELD function fails
and the program terminates with a run-time error.

**pattern** must contain specifiers to cover all characters contained
in string. For example, the following statement returns an empty
string because not all parts of string are specified in the pattern:

    MATCHFIELD('XYZ123AB', '3X3N', 1)

To achieve a positive pattern match on the string above, use the
following statement:

    MATCHFIELD('XYZ123AB', '3X3N0X', 1)

This statement returns a value of "XYZ".

## NOTES

See also: [MATCHES](https://jbc-lang.org/pages/matches.md) operator for information about pattern
matching.

## EXAMPLES

        Q = MATCHFIELD('AA123BBB9', '2A0N3A0N', 3)
        PRINT 'Q=', Q                               ;*  Q=     BBB
        ADDR = '20 GREEN ST. NATICK, MA.,01234'
        ZIP = MATCHFIELD(ADDR, '0N0X5N', 3)
        PRINT 'ZIP=' , ZIP                          ;*  ZIP=   01234
        UNV = 'PART12345 BLUE AU'
        COL = MATCHFIELD(UNV, '10X4A3X', 2)
        PRINT 'COL= ', COL                          ;*  COL=   BLUE
        XYZ = MATCHFIELD('ABCDE1234', '2N3A4N', 1)
        PRINT 'XYZ= ', XYZ                          ;*  XYZ=
        ABC = MATCHFIELD('1234AB', '4N1A', 2)
        PRINT 'ABC= ', ABC                          ;*  ABC=
