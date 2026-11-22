# @DATA

***TAFJ note: not supported.***

Data statements used in conjunction with INPUT statements are
stored in data stack or input queue. This stack is accessible
in the @DATA variable:

       DATA 'QWE'
       DATA 'RTY'
       CRT SYSTEM(14)   ;* number of bytes in data stack (EOL characters included)
       CRT DQUOTE(@DATA)
       CRT SYSTEM(14)   ;* after output of @DATA there's nothing in a queue

Output of this program:

<pre>
    8
    "QWE
    RTY
    "
    0</pre>
