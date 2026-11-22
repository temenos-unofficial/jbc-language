# Dynamic arrays

To assign or extract a field/value/subvalue from a dynamic array,
use string concatenation method (**:**) or angle brackets:

       V.ARRAY = 1 :@FM: 2 :@FM: 3 :@FM: 4 :@VM: 5 :@VM: 6 :@SM: 7
       CRT V.ARRAY<2>               ;* 2
       CRT V.ARRAY<4,3,1>           ;* 6
       V.ARRAY<2> += 1
       CRT V.ARRAY<2>               ;* 3
       V.ARRAY<-1> = 10             ;* adds an element to the end
    * Nesting is allowed:
       V.CNT = 1 :@FM: 3 :@FM: 5
       V.ARRAY<V.CNT<2>> = 77
       CRT FMT(V.ARRAY, 'MCP')      ;* 1^3^77^4]5]6\7^10

Note that array elements are numbered starting from 1 rather that 0.
