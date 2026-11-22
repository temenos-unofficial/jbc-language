# REPLACE

REPLACE is an obsolete way to assign to dynamic arrays via a function.

## COMMAND SYNTAX

    REPLACE(var, expression1{, expression2{, expression3}}; expression4)

## SYNTAX ELEMENTS

**var** is the dynamic array that the REPLACE function will use to assign
new values; remains unchanged.

**expression1** specifies into which field assignment will be made and
should evaluate to a numeric.

**expression2** specifies into which value assignment is to be
done and should evaluate to a numeric.

**expression3** specifies into which sub-value assignment is to be
done and should evaluate to a numeric.

**expression4** can evaluate to any data type and is the actual data
that will be assigned to the array.

## NOTES

The function returns a copy of var with the specified replacement
carried out. This value may be assigned to the original var in which
case the jBC compiler will optimize the assignment.

## EXAMPLE

       X = "jBASE" :@VM: "is" :@VM: "great" :@FM: '!'
       Y = REPLACE(X, 1, 2; 'is really')
       CRT FMT(X, 'MCP')                    ;*  jBASE]is]great^!
       CRT FMT(Y, 'MCP')                    ;*  jBASE]is really]great^!
