# WRITELIST

WRITELIST allows the program to store a list held in a jBC variable to
the global list file.

## COMMAND SYNTAX

    WRITELIST variable ON | TO expression { SETTING setvar } { ON ERROR statements }

## SYNTAX ELEMENTS

**variable** is the variable in which the list is held.

**expression** should evaluate to the required list name. If expression
is null, it writes the list to the default external list.

If the SETTING clause is specified and the write fails, it sets setvar
to one of the following values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTE

See also: [DELETELIST](https://jbc-lang.org/pages/deletelist.md), [READLIST](https://jbc-lang.org/pages/readlist.md),
[FORMLIST](https://jbc-lang.org/pages/formlist.md)

## EXAMPLE

       EXECUTE 'SELECT . SAMPLE 5' RTNLIST V.LIST
       WRITELIST V.LIST TO 'SOME-FILES'
       GETLIST 'SOME-FILES' TO V.FILES.L ELSE NULL
       CRT OCONV( V.FILES.L, 'MCP' )  ;* e.g. &COMO&^&COMO&]D^&ED&^&ED&]D^&PH&
