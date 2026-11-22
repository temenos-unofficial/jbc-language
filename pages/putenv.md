# PUTENV

PUTENV is used to set environment variables for the current process.

## COMMAND SYNTAX

    PUTENV(expression)

## SYNTAX ELEMENTS

**expression** should evaluate to a string of the form:

EnvVarName=value

where

EnvVarName is the name of a valid environment variable and value is
any string that makes sense to the variable being set.

If PUTENV function succeeds it returns a Boolean TRUE value, if it
fails it will return a Boolean FALSE value.

## NOTES

PUTENV only sets environment variables for the current process and
processes spawned (say by EXECUTE) by this process. These variables
are known as export only variables.

See also: [GETENV](https://jbc-lang.org/pages/getenv.md)

## EXAMPLE

       V.ENV = 'JBASE_ERRMSG_ZERO_USED'
       IF NOT( PUTENV(V.ENV : '=35') ) THEN
          CRT 'PUTENV failed'
          STOP
       END
       CRT 'See the impact of JBASE_ERRMSG_ZERO_USED'
       CRT '=35'
       CRT V.VAR     ;* variable not assigned; nothing is being output
       IF NOT( PUTENV(V.ENV : '=0') ) THEN
          CRT 'PUTENV failed'
          STOP
       END
       CRT '=0'
       CRT V.VAR     ;* Invalid or uninitialised variable --  NULL USED ,
                     ;* Var (UNKNOWN) , Line    17 , Source test.b
