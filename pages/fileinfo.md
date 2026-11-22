# FILEINFO

Use the FILEINFO function to return information about the specified file
variable.

## COMMAND SYNTAX

    FILEINFO(file.variable, key)

If **key** is 0, this function returns 1 if file.variable is a valid file variable, zero otherwise.
If **key** is 1, this function returns file status information.

## EXAMPLES

       IF NOT( GETENV('JEDIFILENAME_SYSTEM', FN.SYSTEM) ) THEN ABORT
       OPEN FN.SYSTEM TO F.SYSTEM ELSE NULL
       OPEN 'SOMENONEXISTENTFILE' TO F.SOMEFILE ELSE NULL
       CRT FILEINFO(F.SYSTEM, 0)        ;* 1
       CRT FILEINFO(F.SOMEFILE, 0)      ;* 0

       IF NOT( GETENV('TAFC_HOME', tafc_home) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       //
       log_dir = tafc_home : '/tmp'
       log_file = 'jbase_error_trace'
       //
       OPENSEQ log_dir, log_file READONLY TO f_log THEN
          CRT FMT( FILEINFO(f_log, 1), 'MCP' )
       END ELSE
          CRT 'jbase_error_trace not found'
       END

Sample output from the second example:

<pre>
    0^0^0^0^100666^107817^1^0^0^70770^24915^24915^34405^16705^25887^16643
    ^39761^16220^0^C:\home\kzm\v-t24\r11\tafc/tmp\jbase_error_trace^SEQ^0
    ^0^0^0^0^C:\home\kzm\v-t24\r11\tafc/tmp\jbase_error_trace^0^0^unknown</pre>

***TAFJ note: for C:\Temenos\TAFJ\bin\DBTools.bat there's "XMLMSSQL" in field 21 (should be "SEQ").***
