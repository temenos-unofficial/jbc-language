# CLEARCOMMON

The CLEARCOMMON statement initializes all unnamed common variables to
a value of zero.

## COMMAND SYNTAX

    CLEARCOMMON

## EXAMPLE

       COMMON /MY.COMM/ global_var
       COMMON gl_unnamed
       global_var = 1000
       gl_unnamed = 1001
       CLEARCOMMON
    * only unnamed common will be cleared
       CRT global_var                           ;* 1000
       CRT gl_unnamed                           ;* 0

***TAFJ note: Variables in named COMMON area ARE cleared by CLEARCOMMON.***
