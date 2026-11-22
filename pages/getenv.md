# GETENV

All processes have an environment associated with them that contains a
number of variables indicating the state of various parameters. The
GETENV function allows a jBC program to determine the value of any of
the environment variables associated with it.

## COMMAND SYNTAX

    GETENV(expression, variable)

## SYNTAX ELEMENTS

The expression should evaluate to the name of the environment variable
whose value is to be returned. The function will then assign the value
of the environment variable to variable. The function itself returns a
Boolean TRUE or FALSE value indicating the success or failure of the
function.

See: [PUTENV](https://jbc-lang.org/pages/putenv.md)

## EXAMPLE

    IF GETENV('PATH', ExecPath) THEN
        CRT "Execution path is " : ExecPath
    END ELSE
        CRT "Execution path is not set up"
    END

## EXAMPLE 2 (TAFJ). Get TAFJ configuration parameter

       ret_code = GETENV('temn.tafj.compiler.internal.development', int_devt)
       CRT int_devt    ;* false or true
