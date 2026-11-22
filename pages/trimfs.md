# TRIMFS

TRIMFS function is used to remove all leading spaces
from each element of dynamic.array.

## COMMAND SYNTAX

    TRIMFS(dynamic.array)

If dynamic.array evaluates to null (i.e. an empty string), null is returned.
If any element of dynamic.array is null, null is returned for that value.

## EXAMPLE

       dyn_array = ' Use    ' :@FM: ' the   ' :@VM: '' :@FM: 'source Luke   !  '
       CRT DQUOTE( OCONV( TRIMFS(dyn_array), 'MCP') )
       * Compare this with TRIMBS()
       CRT DQUOTE( OCONV( TRIMBS(dyn_array), 'MCP') )

Output:

<pre>
    "Use    ^the   ]^source Luke   !  "
    " Use^ the]^source Luke   !"</pre>
