# DEFFUN

Use the DEFFUN statement to declare an external jBC function to the jBC
compiler and optionally define its arguments. Use DEFFUN in the program
that calls the function.

## COMMAND SYNTAX

    DEFFUN FuncName ({ { MAT } Argument1, { MAT } Argument2...})

## SYNTAX ELEMENTS

**FuncName** is the name used to define the function. It must be the
same as the source file name.

**Argument** specifies a value passed to the function by the calling
program. To pass an array, the keyword you must use the MAT before the
argument name. These parameters are optional (as indicated in the
command syntax) but can be specified for clarity. Note that if the
arguments are not initialized somewhere in the program you will receive
a compiler warning.

## NOTES

The DEFFUN statement identifies a user-written function to the jBC
compiler, which must be present in each program that calls the
function, before the function is called. A hidden argument is passed
to the function so that a value can be returned to the calling program.
The return value is set in the function using the RETURN (value)
statement. If the RETURN statement specifies no value then the function
returns an empty string.

## EXAMPLE 1###

    DEFFUN Add()
    A = 10
    B = 20
    sum = Add(A, B)
    PRINT sum
    X = RND(42)
    Y = RND(24)
    PRINT Add(X, Y)

    FUNCTION Add(operand1, operand2)
    result = operand1 + operand2
    RETURN(result)
