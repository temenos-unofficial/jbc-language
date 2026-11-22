# READLIST

READLIST allows the program to retrieve a previously stored list
(perhaps created with the SAVE-LIST command), into a jBC variable.

## COMMAND SYNTAX

    READLIST variable1 FROM expression { SETTING variable2 } THEN | ELSE statements

## SYNTAX ELEMENTS

**variable1** is the variable into which the list will be read.

**expression** should evaluate to the name of a previously stored
list to retrieve. If specified, **variable2** will be set to the
number of elements in the list.

If the statement succeeds in retrieving the list, then the
statements associated with any THEN clause will be executed.
If the statement fails to find the list, then the statements
associated with any ELSE clause will be executed.

## NOTES

READLIST statement is identical in function to the
[GETLIST](https://jbc-lang.org/pages/getlist.md) statement.

See also: [DELETELIST](https://jbc-lang.org/pages/deletelist.md), [FORMLIST](https://jbc-lang.org/pages/formlist.md),
[WRITELIST](https://jbc-lang.org/pages/writelist.md)

## EXAMPLES

Find the list first

    READLIST MyList FROM "MyList" ELSE STOP
    LOOP
    * Loop until there are no more elements
    WHILE READNEXT Key FROM MyList DO
    ......
    REPEAT
