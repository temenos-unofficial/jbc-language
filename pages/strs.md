# STRS

STRS function is used to produce a dynamic array containing the
specified number of repetitions of each element of dynamic.array.

## COMMAND SYNTAX

    STRS(dynamic.array, repeat)

**dynamic.array** is an expression that evaluates to the strings
to be generated.

**repeat** is an expression that evaluates to the number of times
the elements are to be repeated. If it does not evaluate to a value
that can be truncated to a positive integer, an empty string is
returned for dynamic.array.

If dynamic.array evaluates to null, it returns null. If any element
of dynamic.array is null, null is returned for that element. If
repeat evaluates to null, the STRS function fails and the program
enters the debugger.

## EXAMPLES

    ABC= "A" :@VM: "B" :@VM: "C"
    PRINT STRS(ABC,3)

The output of this program is:

<pre>
    AAA]BBB]CCC</pre>
