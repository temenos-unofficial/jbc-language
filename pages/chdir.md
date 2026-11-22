# CHDIR

The CHDIR function allows the current working directory, as seen by the
process environment, to be changed.

## COMMAND SYNTAX

    CHDIR(expression)

## SYNTAX ELEMENTS

The expression should evaluate to a valid path name within the file
system. The function returns a Boolean TRUE result if the CHDIR
succeeded and a Boolean FALSE result if it failed.

## EXAMPLE

    INCLUDE JBC.h
       IF GETENV('TAFC_HOME', tafc_home) THEN
          IF CHDIR(tafc_home : DIR_DELIM_CH : 'config') ELSE
             CRT "TAFC configuration cannot be found"
             ABORT
          END
       END ELSE CRT 'TAFC home can not be found'
