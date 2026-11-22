# @SELECTED

Number of elements from the last select list - Non stacked.

## EXAMPLE

       proc_fname = SYSTEM(1027)
       OPEN proc_fname TO proc_file ELSE STOP 201, "PROC"
       SELECT proc_file TO proc_list
       CRT @SELECTED                                 ;* 0 - this is BASIC select
       EXECUTE 'SELECT ' : proc_fname : ' TO 9'
       CRT @SELECTED                                 ;* 0 - that's not default list
       EXECUTE 'SELECT ' : proc_fname
       CRT @SELECTED                                 ;* number of active sessions
