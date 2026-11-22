# @DATE

Returns the internal date; on some systems, this
differs from the DATE() function in that the variable is set when
program execution starts, whereas the function reflects the current
date:

      CRT @DATE               ;* e.g. 16349
      CRT OCONV(@DATE, 'D')   ;* date represented by 16349 is 04 OCT 2012
