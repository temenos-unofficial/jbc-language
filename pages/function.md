# FUNCTION

Identifies a user-defined function, which can be invoked by other jBC
programs, arguments to the function can optionally be declared.

## COMMAND SYNTAX

    FUNCTION name({ MAT } variable, { MAT } variable...)

## SYNTAX ELEMENTS

Name is the name by which the function is invoked.

Variable is an expression used to pass values between the calling
program and the function.

## NOTES

Use the FUNCTION statement to identify user-written source code
functions. Each function must be coded in separate records and the
record Id must match that of the Function Name, which in turn should
match the reference in the calling program.

The optional comma separated variable list can be a number of
expressions that pass values between the calling programs and the
function. To pass an array the variable name must be preceded by the
MAT keyword. When a user-written function is called, the calling program
must specify the same number of variables that are specified in the
FUNCTION statement.

An extra 'hidden' variable is used to return a value from the
user-written function. The value to be returned can be specified
within the Function by the RETURN (value) statement. If using the
RETURN statement without a value then by default it returns an empty
string.

The calling program must specify a DEFFUN or DEFB statement to describe
the function to be called and the function source must be cataloged and
locatable similar to subroutines.

## EXAMPLE

The function:

        FUNCTION ADD.FUNC(operand1, operand2)
        result = operand1 + operand2
        RETURN(result)
    END

The calling program:

       DEFFUN ADD.FUNC()
       CRT ADD.FUNC(1, 2)           ;* 3
       CRT ADD.FUNC(100, 200)       ;* 300
