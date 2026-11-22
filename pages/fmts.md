# FMTS

Use the FMTS function to format elements of dynamic array for output.
Each element of the array is independently acted upon and returned as
an element in a new dynamic array.

## COMMAND SYNTAX

    FMTS(dynamic.array, format)

## SYNTAX ELEMENTS

**format** is an expression that evaluates to a string of formatting
codes. The Syntax of the format expression is:

[width] [background] justification [edit] [mask]

The format expression specifies the width of the output field, the
placement of background or fill characters, line justification,
editing specifications, and format masking.

For complete syntax details, See also: [FMT](https://jbc-lang.org/pages/fmt.md) function.

If dynamic.array evaluates to null, it returns null. If format
evaluates to null, the FMTS function fails and the program enters
the debugger.

## EXAMPLE

       X = 1234.56 :@FM: 123456.78 :@FM: -123456.78 :@FM: 1234567890
       CRT OCONV( FMTS(X, 'R2*12'), 'MCP' )

Output:

<pre>
    &lowast;&lowast;&lowast;&lowast;&lowast;1234.56^&lowast;&lowast;&lowast;123456.78^&lowast;&lowast;-123456.78^234567890.00</pre>
