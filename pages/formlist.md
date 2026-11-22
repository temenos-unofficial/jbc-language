# FORMLIST

The FORMLIST statement creates an active select list from a
dynamic array.

## COMMAND SYNTAX

    FORMLIST dyn.array { TO listname | listnum }

## SYNTAX ELEMENTS

**dyn.array** specifies the dynamic array from which the active
select list is to be created

If **listname** is specified then the newly created list will be
placed in the variable. Alternatively, a select list number in the
range 0 to 10 can be specified with listnum. If neither listname
nor listnum is specified then the default list variable will be
assumed.

## NOTES

See also: [DELETELIST](https://jbc-lang.org/pages/deletelist.md), [READLIST](https://jbc-lang.org/pages/readlist.md), [WRITELIST](https://jbc-lang.org/pages/writelist.md)

## EXAMPLE

    MyList = "key1":@AM:"key2":@AM:"key3"
    FORMLIST MyList TO ListVar
    //
    LOOP
       READNEXT Key FROM ListVar ELSE EXIT
       READ Item FROM Key THEN
       * Do whatever processing is necessary on Item
       END
    REPEAT
