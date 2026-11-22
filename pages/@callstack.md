# @CALLSTACK

***TAFJ note: not supported.***

Intended to return current call stack information; isn't yet
implemented. SYSTEM(1029) could be used to obtain call stack information, e.g:

Main program (test.b):

       GOSUB SECTION1
       STOP
       *-------------
    SECTION1:
       GOSUB SECTION2
       RETURN
       *-------------
    SECTION2:
       CRT OCONV( SYSTEM(1029), 'MCP' )
       CALL TEST.SUB
       RETURN
    END

Subroutine:

       SUBROUTINE TEST.SUB
    *
       GOSUB SECTION3
       RETURN
       *-------------
    SECTION3:
       CRT OCONV( SYSTEM(1029), 'MCP' )
       RETURN
    END

Output:

<pre>
    1\2\6\test.b]1\1\1\test.b
    2\1\3\TEST.SUB]1\3\12\test.b]1\2\6\test.b]1\1\1\test.b</pre>
