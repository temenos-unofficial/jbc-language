# CHAIN

The CHAIN statement exits the current program and transfers process
control to the program defined by the expression. Process control will
never return to the originating program.

## COMMAND SYNTAX

    CHAIN expression

## SYNTAX ELEMENTS

The expression should evaluate to a valid UNIX or Windows command (this
may be another jBC program). The command string may be suffixed with
the (I option, which will cause any COMMON variables in the current
program to be inherited by the new program (providing it is a jBC
program).

## NOTES

There are no restrictions to the CHAIN statement and you may CHAIN from
anywhere to anywhere. However, it is advisable that your program
follows a logical path easily seen by another programmer. If the
program, which contains the CHAIN command (the current program) was
called from a JCL program, and the program to be executed (the target
program) is another jBC program, control will return to the original JCL
program when the target program terminates. If the target program is a JCL
program, control will return to the command shell when the JCL program
terminates.

## EXAMPLES

        CHAIN "OFF" ;* exit via the OFF command

        ! Prog1
        COMMON A,B
        A = 50 ; B = 100
        CHAIN "NEWPROG (I"

        ! NEWPROG
        COMMON I,J
        ! I and J inherited
        CRT I,J
