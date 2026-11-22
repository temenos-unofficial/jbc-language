# OBJEXCALLBACK

jBASE OBjEX provides the facility to call a subroutine from a front-end
program written in a tool that supports OLE, such as Delphi or Visual
Basic. The OBJEXCALLBACK statement allows communication between the
subroutine and the calling OBjEX program.

## COMMAND SYNTAX

    OBJEXCALLBACK expression1, expression2 THEN | ELSE statements

## SYNTAX ELEMENTS

**expression1** and **expression2** can contain any data. They are
returned to the OBjEX program where they are defined as variants.

If the subroutine containing the OBJEXCALLBACK statement is not called
from an OBjEX program (using the Call Method) then the ELSE clause will
be taken.

## NOTES

The OBJEXCALLBACK statement is designed to allow jBC subroutines to
temporarily return to the calling environment to handle exception
conditions or prompt for additional information. After servicing this
event, the code should return control to the jBC program to ensure that
the proper clean up operations are eventually made. The two parameters can
be used to pass data between the jBC and OBjEX environments in both
directions. They are defined as Variants in the OBjEX environment and as
normal variables in the jBC environment.

See the OBjEX documentation for more information.

## EXAMPLE

    param1 = "SomeActionCode"
    param2 = ProblemItem
    OBJEXCALLBACK param1, param2 THEN
    * this routine was called from ObjEX
    END ELSE
    * this routine was not called from ObjEX
    END
