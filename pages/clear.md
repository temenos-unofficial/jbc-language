# CLEAR

The CLEAR statement will initialize all local variables to numeric 0.

## COMMAND SYNTAX

    CLEAR

## NOTES

Use CLEAR at any time during the execution of the program.

## EXAMPLE

       COMMON /MY.COMM/ global_var
       global_var = 1000
       var = 5            ;   CRT var           ;* 5
       var ++             ;   CRT var           ;* 6
       CLEAR
    * only regular variables will be cleared
       CRT var                                  ;* 0
       CRT global_var                           ;* 1000
