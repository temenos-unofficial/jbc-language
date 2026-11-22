# Note 2

OCONV() or FMT() with second parameter 'MCP' is often used; its only purpose is
to convert FM, VM and SM delimiters to a printable form, e.g.:

       V.ARRAY = 1 :@FM: 2 :@VM: 3 :@FM: 4 :@SM: 5
       CRT FMT(V.ARRAY, 'MCP')                ;*   1^2]3^4\5

Where possible, the output is shown in a comment (as it is in the example above).

***TAFJ note: 'MCP' option doesn't work neither for OCONV() nor for FMT(). The former keeps delimiters as they are, the latter returns just 'CP'. Workaround: use CONVERT(@FM:@VM:@SM, '^]\', V.ARRAY)***
