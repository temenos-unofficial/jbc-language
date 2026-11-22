# Other notes

"=" character can be used both for assignment and for a comparison,
though it's possible to use "EQ" in the latter case:

       V.STRING = 'ABC'
       IF V.STRING = 'ABC' THEN CRT 'YES'
       IF V.STRING EQ 'ABC' THEN CRT 'YES AGAIN'

"Non-equal" can either be "#", "!", "<>" or "NE":

       a_string = 'ABC'
       IF a_string #  'A' THEN CRT 'Not an "A"'
       IF a_string NE 'B' THEN CRT 'Not a "B"'
       IF a_string ! 'C' THEN CRT 'Not even a "C"'
       IF a_string <> 'D' THEN CRT 'Surprisingly, but neither a "D"'

IF...ELSE construct can be used without THEN:

       V.STRING = 'ABC'
       IF V.STRING NE 'ABC' ELSE CRT 'YES'

## Differences between emulations

For T24 emulation should always be **prime**, however for porting the code it's
crucial to understand the differences.

See several examples below.

The following
code will run successfully under **prime** emulation and will fail under **ros**:

       ret_code = GETENV('JBCEMULATE', jbc_emu)   ;   CRT jbc_emu
       dyn_array = 3 :@AM: 7
       dyn_array += 4
       CRT FMT(dyn_array, 'MCP')

Runtime:

<pre>
    prime
    7^7</pre>

<pre>
    ros
    Non-numeric value -- ZERO USED ,
    Variable 'dyn_array' , Line     3 , Source test.b
    Trap from an error message, error message name = NON_NUMERIC</pre>

*Setting in Config_EMULATE: ***no_value_maths = false|true**

Next program outputs *<>* under **prime** and *<0>* under **seq**
emulation. In the latter case there will be zero-sized file *report.txt* after
program termination. So if, for example, nothing was written to a report
under **prime** emulation (or, in fact, any other except **seq**),
there will be no output file left after that.

Source code:

       dir_name = '.'
       file_name = 'report.txt'
       DELETESEQ dir_name, file_name ELSE NULL
       *
       OPENSEQ dir_name, file_name TO f_report THEN NULL
       CRT '<' : DIR(file_name)<1> : '>'

*Setting in Config_EMULATE: ***openseq_creates = false|true**

The following program outputs *1* under **prime** emulation and *0*
under **r83**, thus showing that common variables can be assigned or
unassigned upon declaration of COMMON area:

       COMMON /MY.COMM/ var_1, var_2
       *
       CRT ASSIGNED(var_1)

*Setting in Config_EMULATE: ***named_common = unassigned|null|zero**

The next program outputs *A^1^2^3^4^5* under **seq** or **r83**
emulations; under others (that do add additional
delimiter even if one exists at the end of an array in question) the output
will be: *A^^1^2^3^4^5*.

Source code:

       dyn_array = 'A' : @FM
       FOR i = 1 TO 5
          dyn_array<-1> = i
       NEXT i
       CRT OCONV(dyn_array, 'MCP')

*Setting in Config_EMULATE: ***no_extra_delimiter = false|true**

The following *READV* example outputs *REC1* (i.e. record key) when is
run under **jbase** emulation and *3* (i.e. fields count) under, e.g.,
**ap** or **r83**:

       OPEN 'F.TEMP' TO f_temp THEN
          ret_error = ''
          CLEARFILE f_temp SETTING ret_error
          IF ret_error NE '' THEN
             CRT 'ERROR ' : ret_error
             STOP
          END
       END ELSE
          EXECUTE 'CREATE-FILE DATA F.TEMP 1 101 TYPE=J4'
          OPEN 'F.TEMP' TO f_temp ELSE ABORT 201, 'F.TEMP'
       END
       *
       out_record = 'LINE 1' :@FM: 'LINE 2' :@FM: 'LINE 3'
       WRITE out_record TO f_temp, 'REC1'
       *
       READV in_record FROM f_temp, 'REC1', 0 ELSE
          CRT 'Read error'
          STOP
       END
       *
       CRT in_record

*Setting in Config_EMULATE: ***readv0 = key|dcount|binary**

Some settings are effective at runtime, others apply during compilation.
For example, the following program compiles successfully under **prime**
emulation and runs successfully after that under all emulations.
However, it's not possible to compile it under, say, **jbase** emulation.
Reason of error - redimensioning of an array.

Code:

       DIMENSION dyn_array(10)
       MAT dyn_array = '!'
       dyn_array(5) = '?'
       FOR i = 1 TO 10
          CRT dyn_array(i):          ;* !!!!?!!!!!
       NEXT i
       DIM dyn_array(15)
       dyn_array(15) = '...'
       CRT dyn_array(15)

Compilation under **jbase** emulation:

<pre>
    [error 1        (32)] "test.b", 7 (offset 18)  near ")":
    Array dyn_array has already been DIMensioned
    &nbsp;
    1 error was found</pre>

*Setting in Config_EMULATE: ***resize_array = false|true**

Another example:

    * number of seconds past midnight
       CRT SYSTEM(12)   ;* e.g. 30938703.4097 under prime, 309387 under ros

For more settings see *Config_EMULATE* and *Config_EMULATE.txt*
files in your TAFC/config folder.
