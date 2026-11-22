# @TIME

Returns the internal time - on some systems, this differs from the
TIME function in that the variable is set when program execution
starts, whereas the function reflects the current time.

## EXAMPLE

       MSLEEP 3000
       CRT @TIME, TIME()     ;*  e.g. 26359   26362
