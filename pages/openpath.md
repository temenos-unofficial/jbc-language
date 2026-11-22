# OPENPATH

OPENPATH statement is used to open a file (given an absolute or
relative path) to a descriptor variable within jBC.
See also: [OPEN](https://jbc-lang.org/pages/open.md) statement.

## COMMAND SYNTAX

    OPENPATH expression1 TO {variable} { SETTING setvar } THEN | ELSE statements

## SYNTAX ELEMENTS

**expression1** should be an absolute or relative path to the file
including the name of the file to be opened. If specified, variable
will be used to hold the descriptor for the file. It should then be
to access the file using READ and WRITE. If no file descriptor
variable is supplied, then the file will be opened to the default
file descriptor.

If the **OPENPATH** statement fails it will execute any statements
associated with an ELSE clause. If successful, the OPENPATH will
execute any statements associated with a THEN clause. Note that
the syntax requires either one or both of the THEN and ELSE
clauses.

If the **SETTING** clause is specified and the open fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

The path specified may be either a relative or an absolute path
and must include the name of the jBASE file being opened.

The file that is the subject of the OPENPATH statement can be of
any type known to the jBASE system. Its type will be determined
and correctly opened transparently to the application, which need
not be aware of the file type.

A jBC program can open an unlimited amount of files.

## EXAMPLES

    OPENPATH "C:\Home\CUSTOMERS" TO F.Customers ELSE
       ABORT 201, "CUSTOMERS"
    END

Opens the file CUSTOMERS (located in C:\Home) to its own file
descriptor F.Customers

    OPEN "F:\Users\data\CUSTOMERS" ELSE ABORT 201, "CUSTOMERS"

Opens the CUSTOMERS file (located in F:\Users\data) to the default
file variable.
