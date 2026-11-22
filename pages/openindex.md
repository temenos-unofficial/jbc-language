# OPENINDEX

OPENINDEX statement is used to open a particular index definition for
a particular file. This index file variable can later be used with
the SELECT statement.

## COMMAND SYNTAX

    OPENINDEX filename,indexname TO indexvar { SETTING setvar } THEN  \
      | ELSE statements

## SYNTAX ELEMENTS

**filename** should correspond to a valid file which has at least one
index.

**indexname** should correspond to an index created for the filename.

**indexvar** is the variable that holds the descriptor for the index.

If the **OPEN** statement fails then it will execute any statements
associated with an ELSE clause. If the **OPEN** is successful then it
will execute any statements associated with a THEN clause. Note that the
syntax requires either one or both of the THEN and ELSE clauses.

If the **SETTING** clause is specified and the OPEN fails, setvar will be
set to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## EXAMPLES

    OPENINDEX "CUSTOMER","IXLASTNAME" TO custlastname.ix SETTING errval ELSE
      CRT "OPENINDEX failed for file CUSTOMER, index IXLASTNAME"
      ABORT
    END
