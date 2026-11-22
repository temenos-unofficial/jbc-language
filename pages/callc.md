# CALLC

The CALLC command transfers program control to an external function
(c.sub.name). The second form of the syntax calls a function whose name
is stored in a jBC variable (@var). The program could pass back return
values in variables. CALLC arguments can be simple variables or complex
expressions, but not arrays. Use CALLC as a command or function.

## COMMAND SYNTAX

    CALLC c.sub.name [(argument1[,argument2]...)]

    CALLC @var [(argument1[,argument2]...)]

**Calling a C Program in TAFC**

You must link the C program to TAFC before calling it from a BASIC
program. Perform the following procedure to prepare TAFC for CALLC:

- Write and compile the C program.
- Define the C program call interface
- Build the runtime version of TAFC (containing the linked C program).
- Write, compile, and execute the Basic program

**Calling a Function in Windows NT**

The CALLC implementation in TAFC for Windows NT or Windows 2000 uses
the Microsoft Windows Dynamic Link Library (DLL) facility. This
facility allows separate pieces of code to call one another without
permanently binding together. Linking between the separate pieces
occurs at runtime (rather than compile time) through a DLL interface.

For CALLC, developers create a DLL and then call that DLL from TAFC.

## EXAMPLES

In the following example, the called subroutine draws a circle with
its center at the twelfth row and twelfth column and a radius of 3:

    RADIUS = 3
    CENTER = "12,12"
    CALLC DRAW.CIRCLE(RADIUS,CENTER)

In the next example, the subroutine name is stored in the variable
SUB.NAME, and is indirectly called:

    SUB.NAME = DRAW.CIRCLE
    CALLC @SUB.NAME(RADIUS,CENTER)

The next example uses, CALLC as a function, assigning the return
value of the subroutine PROG.STATUS in the variable RESULT:

    RESULT = CALLC PROG.STATUS
