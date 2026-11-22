# SENTENCE

SENTENCE function allows a program to locate the command used to
invoke it and the arguments it was given.

## COMMAND SYNTAX

    SENTENCE({expression})

## SYNTAX ELEMENTS

If expression is specified it should evaluate to a positive integer
value. A negative value will return a null string. A value of null
will return the entire command line.

An integer value of expression will return a specific element of the
command line with the command itself being returned by SENTENCE (0),
the first parameter being returned by SENTENCE(1) and so on.

## NOTES

It is assumed the command line arguments are space separated and when
returning the entire command line they are returned as such. The
SYSTEM(1000) function will return the command line attribute mark
delimited.

## EXAMPLES

       DIM Parm(4)
       ProgName = SENTENCE(0) ;* program is?
       FOR I = 1 TO 4
          Parm(I) = SENTENCE(I) ;* get parameters
       NEXT I

       this_prog = SENTENCE(0)    ;* name of this program
       phrase_part = 'to understand recursion '
       IF SENTENCE(1) EQ '-2' THEN              ;* first parameter
          CRT TRIM( SENTENCE(2), '"', 'B' ):    ;* 2nd parameter
          CRT phrase_part
       END ELSE
          CRT phrase_part:
          EXECUTE this_prog : ' -2 "you firstly need "'
       END

***TAFJ R23 note: results are corrupted after EXECUTE:***

test.b:

       PROGRAM test
       *
       CRT SENTENCE(2)
       EXECUTE 'LIST F.SPF (N' CAPTURING output
       *
       CRT SENTENCE(2)
       *
       STOP
       END

TAFC:

    test arg1 arg2
    >>>
    arg2
    arg2

TAFJ:

    trun test arg1 arg2
    >>>
    arg2
    (N
