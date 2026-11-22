# JQLCOMPILE

JQLCOMPILE compiles a jQL statement.

## COMMAND SYNTAX

    JQLCOMPILE(Statement, Command, Options, Messages)

## SYNTAX ELEMENTS

**Statement** is the variable, which receives the compiled statement.
Majority of functions use the compiled statement to execute and work
on the result set etc.

**Command** is the actual jQL query that you want to compile (such as
SELECT or something similar). Use RETRIEVE to obtain data records as
the verb rather than an existing jQL verb. This will ensure that the
right options are set internally. In addition, use any word that is
not a jQL reserved word as the verb and it will work in the same way
as RETRIEVE: implement a PLOT command that passes the entire command
line into JQLCOMPILE and the results will be the same as if the first
word was replaced with RETRIEVE.

**Option:** You must specify JQLOPT_USE_SELECT to supply a select list
to the JQLEXECUTE function; the compile builds a different execution
plan if using select lists.

**Messages:** If the statement fails to compile, this dynamic array
is in the STOP format, therefore STOP messages can be programmed and
printed. Provides a history of compilation for troubleshooting
purposes; Returns -1 if there is a problem found in the statement
and 0 for no problem.
