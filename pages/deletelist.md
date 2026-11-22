# DELETELIST

The DELETELIST statement will delete the previously stored list
named by expression.

## COMMAND SYNTAX

    DELETELIST expression

## SYNTAX ELEMENTS

The expression should evaluate to the name of a list that has been
stored with either the WRITELIST statement or the SAVE-LIST
command from the shell.

## NOTES

If POINTER-FILE is accessible then it saves lists within else are
saved in the jBASE work file.

## EXAMPLE

       EXECUTE 'SELECT .' :@FM: 'SAVE-LIST FILES-LIST'
       EXECUTE 'LIST &SAVEDLISTS& LIKE FILES-...'    ;*  FILES-LIST is here
       DELETELIST 'FILES-LIST'
       EXECUTE 'LIST &SAVEDLISTS& LIKE FILES-...'    ;* and now it's not
