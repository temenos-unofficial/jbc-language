# READPREV

This statement is syntactically similar to the [READNEXT](https://jbc-lang.org/pages/readnext.md)
but it works in reverse order. There are some considerations when
the direction is changed from forward search to backward search or
vice-versa.

When [SELECT](https://jbc-lang.org/pages/select.md) statement is first executed forward direction
is assumed. Therefore if [SELECT](https://jbc-lang.org/pages/select.md) is immediately followed by
READPREV, then a change of direction is assumed.

During the [READNEXT](https://jbc-lang.org/pages/readnext.md) or READPREV sequence a next-key pointer
is kept up to date. This is the record or index key to be used, should
a [READNEXT](https://jbc-lang.org/pages/readnext.md) be executed.

During a change of direction from forward [READNEXT](https://jbc-lang.org/pages/readnext.md) to
backward [READPREV](https://jbc-lang.org/pages/readprev.md) then the next record key or index key
read in by the READPREV will be the one preceding the next-key pointer.

When the select list is exhausted it will either point one before the
start of the select list (if READPREVs have been executed) or one past
the end of the select list (if READNEXTs have been executed). Thus in
the event of a change of direction the very first or very last index
key or record key will be used.

Behaviour of READNEXT/READPREV depends on emulation. The following example is
for *jbase* emulation:

***TAFJ note: READPREV statement isn't supported.***

## EXAMPLE

Consider the following jBC code

        list = "DAVE" :@FM: "GREG" :@FM: "JIM"
        SELECT list

The following table shows what happens if you do [READNEXT](https://jbc-lang.org/pages/readnext.md)s
and [READPREV](https://jbc-lang.org/pages/readprev.md)s on the above code and the reasons for it.

|Statements executed | Result of operation | Comments                   |
|--------------------|---------------------|----------------------------|
|READNEXT key ELSE   | key becomes "DAVE"  | key becomes "DAVE"         |
|READNEXT key ELSE   | key becomes "GREG"  | Second key in list         |
|READPREV key ELSE   | key becomes "DAVE"  | Reversed so take preceding |
|                    |                     | key                        |
|READPREV key ELSE   | Take ELSE clause    | The next key ptr exhausted |
|                    |                     | at start.                  |
|READNEXT key ELSE   | key becomes "DAVE"  | First key in list          |
|READNEXT key ELSE   | key becomes "GREG"  | Second key in list         |
|READNEXT key ELSE   | key becomes "JIM"   | Final key. Next key ptr    |
|                    |                     | exhausted.                 |
|READPREV key ELSE   | key becomes "JIM"   | Reversed but list          |
|                    |                     | exhausted.                 |
|READPREV key ELSE   | key becomes "GREG"  | Second key in list         |
|READPREV key ELSE   | key becomes "DAVE"  | First key in list          |

## EXAMPLE 2

This code shows the behaviour of READNEXT/READPREV under *prime* emulation.
The difference to the example above starts with the first READPREV:

       list = "DAVE" :@FM: "GREG" :@FM: "JIM"
       SELECT list
       READNEXT V.ID ELSE CRT 'READNEXT 1 FAILED'
       CRT 'NEXT:' : V.ID                              ;*  NEXT:DAVE
       READNEXT V.ID ELSE CRT 'READNEXT 2 FAILED'
       CRT 'NEXT:' : V.ID                              ;*  NEXT:GREG
       READPREV V.ID ELSE CRT 'READPREV 1 FAILED'
       CRT 'PREVIOUS:' : V.ID                          ;*  PREVIOUS:JIM
       READPREV V.ID ELSE CRT 'READPREV 2 FAILED'      ;*  READPREV 2 FAILED
       CRT 'PREVIOUS:' : V.ID                          ;*  PREVIOUS:
       READNEXT V.ID ELSE CRT 'READNEXT 3 FAILED'      ;*  READNEXT 3 FAILED
       CRT 'NEXT:' : V.ID                              ;*  NEXT:
