# PROCREAD

PROCREAD statement is used to retrieve data passed to programs from a
jCL program.

## COMMAND SYNTAX

    PROCREAD variable THEN | ELSE statements

## SYNTAX ELEMENTS

**variable** is a valid jBC identifier, which will be used to store
the contents of the primary input buffer of the last jCL program
called.

If a jCL program does not initiate the program the PROCREAD will fail
and execute any statements associated with an ELSE clause. If the
program was initiated by a jCL program then the PROCREAD will succeed,
the jCL primary input buffer will be assigned to variable and any
statements associated with a THEN clause will be executed.

## NOTES

It is recommended that the use of jCL and therefore the PROCREAD
statement should be not be expanded within your application and
gradually replaced with more sophisticated methods such as UNIX
scripts or jBC programs.

## EXAMPLE

    PROCREAD Primary ELSE
      CRT "Unable to read the jCL buffer"
      STOP
    END
