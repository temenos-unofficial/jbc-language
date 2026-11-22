# ONGOTO

The ON...GOSUB and ON...GOTO statements are used to transfer program
execution to a label based upon a calculation.

## COMMAND SYNTAX

    ON expression GOTO label{, label...}

    ON expression GOSUB label{, label...}

## SYNTAX ELEMENTS

**expression** should evaluate to an integer numeric value. Labels
should be defined somewhere in the current source file.

**ON GOTO** will transfer execution to the labeled source code line
in the program.

**ON GOSUB** will transfer execution to the labeled subroutine within
the source code.

## NOTES

Use the value of expression as an index to the list of labels
supplied. If the expression evaluates to 1 then the first label
will jump to 2 then the second label will be used and so on.

If the program was compiled when the emulation included the setting
generic_pick = true, then no validations are performed on the index
to see if it is valid. Therefore, if the index is out of range this
instruction will take no action and report no error.

If the program was compiled for other emulations then the index will
be range checked. If found that the index is less than 1, it is
assumed to be 1 and a warning message is issued. If the index is found
to be too big, then the last label in the list will be used to transfer
execution and a warning message will be issued.

## EXAMPLE

       cntrl_var = 1
    *
       ON cntrl_var GOSUB BIGGER
       ON cntrl_var GOSUB EXCEPT, SMALLER
       ON cntrl_var GOSUB SMALLER
    *
       STOP
    *
    BIGGER:
       cntrl_var ++
       CRT cntrl_var
       RETURN
    *
    SMALLER:
       cntrl_var --
       CRT cntrl_var
       RETURN
    *
    EXCEPT:
       CRT 'Error occured'
       RETURN
    *
    END

Output of this program:

<pre>
    2
    1
    0</pre>
