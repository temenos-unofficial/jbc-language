# ITYPE

ITYPE function is used to return the value resulting from the
evaluation of an I-type expression in a jBASE file dictionary.

## COMMAND SYNTAX

    ITYPE(i.type)

**I.type** is an expression evaluating to the contents of the compiled
I-descriptor. You must compile the I-descriptor before the ITYPE
function uses it; otherwise, you get a run-time error message.

Using several methods set the I.type to the evaluated I-descriptor in
several ways. One way is to read the I-descriptor from a file
dictionary into a variable, then use the variable as the argument to
the ITYPE function. If the I-descriptor references a record ID, the
current value of the system variable **@ID** is used. If the
I-descriptor, references field values in a data record, the data is
taken from the current value of the system variable @RECORD.

To assign field values to @RECORD, read a record from the data file
into @RECORD before invoking the ITYPE function.

If i.type evaluates to null, the ITYPE function fails and the program
terminates with a run-time error message.

NOTE: Set the @FILENAME to the name of the file before ITYPE execution.

## EXAMPLE

    * Data preparation
    *
       V.FILE = 'F.TEMP'
       EXECUTE 'DELETE-FILE ' : V.FILE
       EXECUTE 'CREATE-FILE ' : V.FILE : ' 1 101 TYPE=J4'
       OPEN V.FILE TO F.TEMP ELSE ABORT 201, 'F.TEMP'
       OPEN 'DICT', V.FILE TO F.TEMP.DICT ELSE ABORT 201, 'F.TEMP]D'
    * Field 1 dictionary entry
       R.DICT.D1 = ''
       R.DICT.D1<1> = 'D'
       R.DICT.D1<2> = '1'
       R.DICT.D1<5> = '25L'
       R.DICT.D1<6> = 'S'
       WRITE R.DICT.D1 TO F.TEMP.DICT, 'FOOTWEAR'
    *
    * I-descriptor
       V.DESCR = 'SIZE'
       R.DICT.I = ''
       R.DICT.I<1> = 'I'
       R.DICT.I<2> = 'FOOTWEAR[":", 2, 1]'
       R.DICT.I<4> = V.DESCR
       R.DICT.I<5> = '3R'
       R.DICT.I<6> = 'S'
       WRITE R.DICT.I TO F.TEMP.DICT, V.DESCR
    *
    * Data records
       R.DATA = ''
       R.DATA<1> = 'SLIPPERS:8'
       WRITE R.DATA TO F.TEMP, 'JIM'
       R.DATA = ''
       R.DATA<1> = 'BOOTS:10'
       WRITE R.DATA TO F.TEMP, 'GREG'
       R.DATA = ''
       R.DATA<1> = 'SLIPPERS:5'
       WRITE R.DATA TO F.TEMP, 'ALAN'
    *
    * Data is prepared; now proceed it
    *
       @FILENAME = V.FILE
       READ V.ITYPE FROM F.TEMP.DICT, V.DESCR ELSE ABORT
    *
       SSELECT F.TEMP TO V.PEOPLE.L
       LOOP
          READNEXT V.ID FROM V.PEOPLE.L ELSE BREAK
          @ID = V.ID
          READ @RECORD FROM F.TEMP, @ID ELSE ABORT
          V.RET = ITYPE(V.ITYPE)
          CRT @ID : "'S FOOTWEAR HAS SIZE " : V.RET
       REPEAT

The output of this program is:

<pre>
    ALAN'S FOOTWEAR HAS SIZE 5
    GREG'S FOOTWEAR HAS SIZE 10
    JIM'S FOOTWEAR HAS SIZE 8</pre>
