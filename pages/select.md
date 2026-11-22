# SELECT

SELECT statement creates a select list of elements in a specified
variable.

## COMMAND SYNTAX

    SELECT {variable1} { TO variable2 | listnum } { SETTING setvar }

## SYNTAX ELEMENTS

**variable1** can be an OPENed file descriptor, in which case the
record keys in the specified file will be selected, or an ordinary
variable in which case each field in the variable will become a list
element. variable1 may also be an existing list in which case the
elements in the list will be selected.

If **variable1** is not specified in the statement then it assumes
the default file variable.

If **variable2** is specified then the newly created list will be
placed in the variable. Alternatively, specify a select list number
in the range 0 to 10 with listnum. If neither variable2 nor listnum
is specified then it assumes the default list variable.

If specifying the SETTING clause and the select fails, it sets setvar
to one of the following values:

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

When constructing a list from record keys in a file, it does so by
extracting only the first few keys, which when removed from the list
obtains the next few keys and so on. Therefore, the creation of the
list is not immediate. This means that the list could contain records,
written to the file after starting the SELECT command.

Consider the situation where you open a file, SELECT it and then,
because of the keys obtained, write new records to the same file. It
would be easy to assume that these new keys would not show up in the
list because you created the list before the new records existed. This
is not the case. Any records written beyond the current position in
the file will eventually show up in the list. In situations where this
might cause a problem, or to ensure that you obtain a complete,
qualified list of keys, you should use a slower external command like
jQL SELECT or [SSELECT](https://jbc-lang.org/pages/sselect.md) and then [READNEXT](https://jbc-lang.org/pages/readnext.md)
to parse the file.

If using a variable to hold the select list, then it should be
unassigned or null before the SELECT. If it contains a number in the
range 0 to 10 then it will use the corresponding select list number
to hold the list, although you can still reference the list with the
variable name. This "feature" is for compatibility with older
platforms. See also example 3.

Lists can be selected as many times as required.

See also: the extensions for secondary indexes.

## EXAMPLE 1

    OPEN "Customers" ELSE ABORT 201, "Customers"
    SELECT TO CustList1
    SELECT TO CustList2

## EXAMPLE 2

    OPEN "Customers" TO CustFvar ELSE ABORT 201, "Customers"
    SELECT CustFvar TO 2
    Done = 0
    LOOP
       READNEXT CustId FROM 2 ELSE Done = 1
    UNTIL Done DO
       GOSUB ProcessCust
    REPEAT

## EXAMPLE 3

    CLEAR
    OPEN "Customers" TO CustFvar ELSE ABORT 201, "Customers"
    OPEN "Products" TO ProdFvar ELSE ABORT 201, "Products"
    SELECT CustFvar TO Listvar1
    SELECT ProdFvar TO Listvar2

This example demonstrates a coding error. The CLEAR statement is used
to initialize all variables to zero. Since Listvar1 has the value 0,
select list number 0 is used to hold the list. However, the CLEAR
statement also initializes Listvar2 to zero, so the second SELECT
overwrites the first list.
