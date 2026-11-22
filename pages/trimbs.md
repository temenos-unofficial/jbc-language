# TRIMBS

TRIMBS function is used to remove all trailing spaces from each element
of dynamic.array.

## COMMAND SYNTAX

    TRIMBS(dynamic.array)

If dynamic.array evaluates to null (i.e. an empty string), null is returned.
If any element of dynamic.array is null, null is returned for that value.

## EXAMPLE

       dyn_array = ' Use    ' :@FM: ' the   ' :@VM: '' :@FM: 'source Luke   !  '
       CRT DQUOTE( OCONV( TRIMBS(dyn_array), 'MCP') )

Output:

<pre>
    " Use^ the]^source Luke   !"</pre>

## NOTE

Leading and redundant spaces are not removed.
