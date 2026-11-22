# READNEXT

READNEXT retrieves the next element in a list variable.

## COMMAND SYNTAX

    READNEXT variable1, variable2 { FROM variable3 } { SETTING setvar }  \
             { THEN | ELSE statements }

## SYNTAX ELEMENTS

**variable1** is the variable into which the next element of the
list will be read.

**variable2** is used when the list has been retrieved externally
from a [SSELECT](https://jbc-lang.org/pages/sselect.md) or similar TAFC command that has used an
exploding sort directive. When specified, this variable will be set
to the multi-value reference of the current element. For example,
if the SSELECT used a BY-EXP directive on field 3 of the records in
a file, the list will contain each record key in the file as many
times as there are multi-values in the field. Each READNEXT instance
will set variable2 to the multi-value in field 3 to which the element
refers. This allows the multi-values in field 3 to be retrieved in
sorted order.

If variable3 is specified with the FROM clause, the READNEXT operates
on the list contained in variable3. If variable3 is not specified, the
default select list variable will be assumed.

If the SETTING clause is specified and the read (to build the next
portion of the list) fails, setvar will be set to one of the following
values:

## INCREMENTAL FILE ERRORS

| Code  | Description                           |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

## NOTES

READNEXT can be used as an expression returning a Boolean TRUE or
FALSE value. If an element is successfully read from the list, TRUE
is returned. If the list was empty, FALSE is returned.

See also: [SELECT](https://jbc-lang.org/pages/select.md), extensions for secondary indexes.

## EXAMPLE

       EXECUTE 'DELETE-FILE DATA F.TEMP'
       EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
       OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       V.REC.INIT = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC.INIT TO F.TEMP, 'REC1'
       WRITE V.REC.INIT TO F.TEMP, 'REC2'
       WRITE V.REC.INIT TO F.TEMP, 'REC3'
       CLOSE F.TEMP
       V.SEL = 'SSELECT F.TEMP TO 9'
       EXECUTE V.SEL
       READNEXT V.ID FROM 9 ELSE CRT 'READNEXT 1 FAILED'
       CRT 'NEXT:' : V.ID                                   ;* NEXT:REC1
       READNEXT V.ID FROM 9 ELSE CRT 'READNEXT 2 FAILED'
       CRT 'NEXT:' : V.ID                                   ;* NEXT:REC2
