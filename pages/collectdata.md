# COLLECTDATA

Use the COLLECTDATA statement to retrieve data passed from the
PASSDATA clause of an EXECUTE statement.

## COMMAND SYNTAX

    COLLECTDATA variable

## SYNTAX ELEMENTS

**variable** is the name of the variable, which is to store the
retrieved data.

## NOTES

Use the COLLECTDATA statement in any program, which is EXECUTEd
(or PERFORMed) by another program where the calling program uses a
PASSDATA clause. The EXECUTEd program uses a COLLECTDATA statement
to retrieve the passed data.

If a PASSDATA clause is not in effect, variable will be assigned a
value of null.

***TAFJ note: COLLECTDATA statement is not supported.***

## EXAMPLE

Program test.b:

       EXECUTE './test2' PASSDATA SYSTEM(40)

Program test2.b:

       COLLECTDATA the_parent
       CRT 'Executed from ' : the_parent

Program test2 executed by itself outputs "Executed from "; execution of program test
will output "Executed from test".

## NOTE

Compile both programs without "-E" switch so shared libraries will be created,
otherwise the data wouldn't be passed between programs.
