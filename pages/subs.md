# SUBS

SUBS function returns a dynamic array, the content of which is
derived by subtracting each element of the second dynamic array
argument from the corresponding element of the first dynamic
array argument.

## COMMAND SYNTAX

    SUBS(DynArr1, DynArr2)

## SYNTAX ELEMENTS

**DynArr1** and **DynArr2** represent dynamic arrays.

## NOTES

Null elements of argument arrays are treated as zero. Otherwise,
a non-numeric element in an argument array will cause a run-time
error.

## EXAMPLE

    X = 1 : @VM : @VM : 5 : @VM : 8 : @SM : 27 : @VM : 4
    Y = 1 : @VM : 5 : @VM : 8 : @VM : 70: @VM : 19
    S = SUBS(X, Y)

The variable S is assigned the value:

    0 : @VM : -5 : @VM : -3 : @VM : -62 : @SM : 27 : @VM : -15
