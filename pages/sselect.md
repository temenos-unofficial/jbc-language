# SSELECT

SSELECT statement is used to create:

A select list of record IDs in sorted order from a jBASE
hashed file

A numbered select list of record IDs from a dynamic array (SSELECTN).

A select list of record IDs from a dynamic array (SSELECTV).

You can then access this select list by a subsequent READNEXT
statement, which removes one record ID at a time from the list.

## COMMAND SYNTAX

    SSELECT [variable] [ TO list.number|select list ] [ ON ERROR statements ]

    SSELECTN [variable] [ TO list.number] [ ON ERROR statements ]

    SSELECTV [variable] TO list.variable [ ON ERROR statements ]

**variable** can specify a dynamic array or a file variable. If
it specifies a dynamic array, the record IDs must be separated by
field marks (ASCII 254). If variable specifies a file variable, the
file variable must have previously been opened. If variable is not
specified, the default file is assumed. If the file is neither
accessible nor open, or if variable evaluates to null, the SSELECT
statement fails and the program enters the debugger with a run-time
error message.

The TO clause specifies the select list that is to be used. list.number
is an integer from 0 through 10. If no list.number is specified, select
list 0 is used.

The record IDs of all the records in the file forms the list. The record
IDs are listed in ascending order. Each record ID is one entry in the
list.

Use the SSELECTV statement to store the select list in a named list
variable instead of to a numbered select list. list.variable is an
expression that evaluates to a valid variable name.

*The ON ERROR Clause*

The ON ERROR clause is optional in SSELECT statements. The ON ERROR
clause lets you specify an alternative for program termination when a
fatal error is encountered during processing of a SSELECT statement.

## INTERNATIONAL MODE

When using the SSELECT statement in International Mode, the statement
will use the currently configured locale to determine the rules by which
each string is considered less than or greater than the other for sort
purposes.

## EXAMPLE

       OPEN 'F.TEMP' TO F.TEMP THEN
          V.ERR = ''
          CLEARFILE F.TEMP SETTING V.ERR
          IF V.ERR NE '' THEN
             CRT 'ERROR ' : V.ERR
             STOP
          END
       END ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       END
       V.REC = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE V.REC TO F.TEMP, 'REC3'
       WRITE V.REC TO F.TEMP, 'REC1'
       WRITE V.REC TO F.TEMP, 'REC2'
       SSELECT F.TEMP TO V.LIST
       READNEXT V.ID FROM V.LIST THEN CRT V.ID        ;*  REC1

## EXAMPLE 2

Using SSELECTV to sort a dynamic array:

       V.RANDOM = ''
       FOR V.I = 1 TO 1000
          V.STRING = ''
          FOR V.J = 1 TO 8
             V.RND = RND(26) + 65
             V.STRING := CHAR(V.RND)        ;* A...Z
          NEXT V.J
          V.RANDOM<-1> = V.STRING
       NEXT V.I
       SSELECTV V.RANDOM TO V.SORTED
       CRT 'Got strings from ' : V.SORTED<1> : ' to ' : V.SORTED<1000>

Sample output:

<pre>
    Got strings from AALUKTJZ to ZZQTIWFQ</pre>

Or:

<pre>
    Got strings from AAGPKJJP to ZZTMYNNX</pre>

## EXAMPLE 3

Don't try to sort an array with **SSELECTV** if this array has values or subvalues (they all will be lost -
after all, it's intended to sort just select lists). The correct way to do that is also shown below:

    *
    init_array = 3 : @VM : 'Third row'
    init_array<-1> = 2 : @VM : 'Second row'
    init_array<-1> = 4 : @VM : 'Fourth row'
    init_array<-1> = 1 : @VM : 'First row'
    &nbsp;
    the_len = DCOUNT(init_array, @FM)
    &nbsp;
    SSELECTV init_array TO sorted_array
    GOSUB SHOW.RESULT
    * Output:
    * 1
    * 2
    * 3
    * 4
    &nbsp;
    elem_to_sort = 1     ;* sort by 1st value
    GOSUB MAKE.SORT
    GOSUB SHOW.RESULT
    * Output:
    * 1]First row
    * 2]Second row
    * 3]Third row
    * 4]Fourth row
    &nbsp;
    elem_to_sort = 2     ;* sort by 2nd value
    GOSUB MAKE.SORT
    GOSUB SHOW.RESULT
    * Output:
    * 1]First row
    * 4]Fourth row
    * 2]Second row
    * 3]Third row
    &nbsp;
    RETURN
    &nbsp;
    MAKE.SORT:
       seek_array = ''
       sorted_array = ''
       FOR i = 1 TO the_len
          LOCATE init_array<i,elem_to_sort> IN seek_array BY 'AN' SETTING ins_posn ELSE NULL
          INS init_array<i,elem_to_sort> BEFORE seek_array<ins_posn>
          INS init_array<i> BEFORE sorted_array<ins_posn>
       NEXT i
       RETURN
    &nbsp;
    SHOW.RESULT:
       FOR i = 1 TO the_len
          CRT OCONV(sorted_array<i>, 'MCP')
       NEXT i
       RETURN
