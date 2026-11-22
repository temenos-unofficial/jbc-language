# INSERT

INSERT is the function form of the INS statement, with preference
given to the use of INS.

## COMMAND SYNTAX

    INSERT(expression1, expression2{, expression3 {, expression4 }}; expression5)

## SYNTAX ELEMENTS

**expression1** evaluates to a dynamic array in which to insert a
new element and will normally be a variable.

**expression2**, **expression3** and **expression4** should evaluate to numeric
values and specify the Field, Value and Sub-Value before which the new
element will be inserted.

**expression5** evaluates to the new element to be inserted in
expression1.

## EXAMPLES

        B = 'Field 1' :@VM: 2 :@VM: 3 :@VM: 5 :@FM: 'Field 2'
        A = INSERT(B, 1, 4; 'Field1Value4')
        CRT OCONV(A, 'MCP')          ;* Field 1]2]3]Field1Value4]5^Field 2
