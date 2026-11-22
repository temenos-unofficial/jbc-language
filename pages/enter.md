# ENTER

The ENTER statement unconditionally passes control to another
executable program.

## COMMAND SYNTAX

    ENTER program_name

    ENTER @variable_name

## SYNTAX ELEMENTS

**program_name** is the name of the program for execution. The use of
single or double quotes to surround program_name is optional.

@ specifies that the program name is contained in a named variable.

**variable_name** is the name of the variable, which contains the
program
name.

## NOTES

***TAFJ note: ENTER statement is not supported.***

The jBC COMMON data area can be passed to another jBC program by
specifying the option "I" after the program name. Pass the COMMON
data area only to another jBC program.

Use ENTER to execute any type of program.

If the program which contains the ENTER command (the current program)
was called from a JCL program, and the program for execution (the target
program) is another jBC program, control will return to the original JCL
program when the target program terminates. If the target program is a
JCL program, control will return to the command shell when the JCL
program terminates.

## EXAMPLES

    ENTER "menu"

    ProgName = "UPDATE"
    ENTER @ProgName
