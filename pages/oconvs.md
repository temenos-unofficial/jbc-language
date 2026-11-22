# OCONVS

OCONVS function converts the elements of dynamic.array to a specified
format for external output.

## COMMAND SYNTAX

    OCONVS(dynamic.array, conversion)

Converts the elements to the external output format specified by
conversion and returns it in a dynamic array.

**conversion** must evaluate to one or more conversion codes separated
by value marks (ASCII 253).

If multiple codes are used, they are applied from left to right as
follows: the left-most conversion code is applied to the element, the next
conversion code to the right is then applied to the result of the first
conversion, and so on.

If dynamic.array evaluates to null, it returns null. If any element of
dynamic.array is null, it returns null for that element. If conversion
evaluates to null, the OCONVS function fails and the program terminates
with a run-time error message.

The STATUS function reflects the result of the conversion:

|Code|   Status                                                  |
|----|-----------------------------------------------------------|
| 0  |   The conversion is successful.                           |
| 1  |   Passes an invalid element to the OCONVS function; the   |
|    |   original element                                        |
|    |   is returned. If the invalid element is null, it returns |
|    |   null for that element.                                  |
|    |   unless dynamic.array is null, in which case it returns  |
|    |   null.                                                   |
| 2  |   The conversion code is invalid.                         |

## NOTES

For information about converting elements in a dynamic array to an
internal format, see also: [ICONVS](https://jbc-lang.org/pages/iconvs.md) function.

## INTERNATIONAL MODE

Description of date, time, number and currency conversions when used
in ICONV and International Mode.
