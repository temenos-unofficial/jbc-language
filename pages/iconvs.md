# ICONVS

Use ICONVS to convert each element of dynamic.array to a specified
internal storage format.

## COMMAND SYNTAX

    ICONVS(dynamic.array, conversion)

## SYNTAX ELEMENTS

**conversion** is an expression that evaluates to one or more valid
conversion codes, separated by value marks (ASCII 253).

Each element of **dynamic.array** is converted to the internal format
specified by conversion and is returned in a dynamic array. If multiple
codes are used, they are applied from left to right. The first
conversion code converts the value of each element of dynamic.array.
The second conversion code converts the value of each element of the
output of the first conversion, and so on. If dynamic.array evaluates
to null, it returns null. If an element of dynamic.array is null, null
it returns null for that element. If conversion evaluates to null, the
ICONV function fails and the program terminates with a run-time error
message.

The STATUS function reflects the result of the conversion:

|Code|     Description                                                   |
|----|-------------------------------------------------------------------|
| 0  |The conversion is successful.                                      |
| 1  |An element of dynamic.array is invalid. It returns an empty string,|
|    |unless dynamic.array is null, in which case it returns null.       |
| 2  |Conversion is invalid.                                             |
| 3  |Successful conversion of possibly invalid data.                    |

See also: [OCONVS](https://jbc-lang.org/pages/oconvs.md) function.
