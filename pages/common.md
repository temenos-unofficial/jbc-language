# COMMON

The COMMON statement declares a list of variables and matrices that
can be shared among various programs. There can be many common areas
including a default, unnamed common area.

## COMMAND SYNTAX

    COMMON { /CommonName/ } variable {, variable ... }

## SYNTAX ELEMENTS

The list of variables should not have been declared or referenced
previously in the program file. The compiler will detect any bad
declarations and display suitable warning or error messages. If the
common area declared with the statement is to be named then the first
entry in the list should be a string, delimited by the / character.

## NOTES

The compiler will not, by default, check that variables declared in
COMMON statements are initialized before they have been used as this
may be beyond the scope of this single source code check. The -JCi
option, when specified to the jBC compiler, will force this check to
be applied to common variables as well. The initialization of named
common is controlled in the Config_EMULATE file.

Variables declared without naming the common area may only be shared
between the program and its subroutines (unless CHAIN is used).
Variables declared in a named common area may be shared across program
boundaries.

Dimensioned arrays are declared and dimensioned within the COMMON
statement.

## EXAMPLE

       COMMON /MY.COMM/ V.VAR1
       CRT ASSIGNED(V.VAR1)   ;* depends on emulation (e.g. 1 for prime)
       CRT V.VAR1             ;* first run: again depends on emulation
                              ;* (e.g. 0 for prime), second run: YES
       CRT ASSIGNED(V.VAR2)   ;* 0
       V.VAR1 = 'YES'
       V.VAR2 = 'NO'

## NOTE

When a COMMON area is used in different programs or subroutines, it has to be
declared in each of them. Variable names can be different but their number has to be the same.

## EXAMPLE

Program test.b:

       COMMON /MY.AREA/ global_var, global_dyn_array
       global_var = 42
       EXECUTE 'test2'

Program test2.b:

       COMMON /MY.AREA/ my_var, my_dyn_array
       CRT my_var

Run program test:

<pre>
    42</pre>

## NOTE

It's a good idea to put COMMON areas declaration for particular task to an insert file and include it
into every relevant source file.

## EXAMPLE

File I_MYTASK.COMMON:

       COMMON /MY.AREA/ global_var, global_dyn_array

Program test.b:

       $INSERT I_MYTASK.COMMON
       &nbsp;
       global_var = 42
       EXECUTE 'test2'

Program test2.b:

       $INSERT I_MYTASK.COMMON
       &nbsp;
       CRT global_var
       CRT ASSIGNED(global_dyn_array)

Run program test (**prime** emulation):

<pre>
    42
    1</pre>

**r83** emulation:

<pre>
    42
    0</pre>

## NOTE

If number of variables in COMMON area changes, all relevant source files are to be recompiled.
