# BREAK

Terminate the currently
executing loop. The EXIT statement is functionally equivalent to
the BREAK statement.

## EXAMPLE

       V.ARRAY = ''
       FOR V.I = 1 TO 10
          IF V.I EQ 4 THEN BREAK
          V.ARRAY<-1> = V.I
       NEXT V.I
       CRT FMT(V.ARRAY, 'MCP') ;* 1^2^3

## NOTE

BREAK terminates the innermost loop; if it's used outside a loop construct
it's ignored. The compiler will issue warning
message 44, and ignore the statement.

## EXAMPLE

       V.ARRAY = ''  ; V.J = 0
       LOOP
          V.J ++
       WHILE V.J LT 3 DO
          FOR V.I = 1 TO 10
    	     IF V.I EQ 4 THEN BREAK
             V.ARRAY<-1> = V.I
          NEXT V.I
       REPEAT
       BREAK
       CRT FMT(V.ARRAY, 'MCP') ;* 1^2^3^1^2^3

Compiler output:

<pre>
    [warning	(44)] "test2.b", 9 (offset 7) :
    BREAK/EXIT is invalid outside a FOR or LOOP - Ignored
    test2.c</pre>
