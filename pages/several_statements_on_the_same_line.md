# Several statements on the same line

Use semicolon to delimit several statements on the same line; don't forget about
code readability. You can combine statements with comments (though as soon as
you have a comment, the following statements turn to comments as well):

    V.VAR = 1  ;  V.VAR++  ;  CRT V.VAR
    V.VAR-- ;* comment starts here so no "1" in the output ; CRT V.VAR
    V.VAR-- ; CRT V.VAR  ;* 0 will be displayed

Conditional statements are also supported (though code readability suffers in
the following example):

    var_1 = 1 ; var_2 = 2 ; IF var_1 + var_2 EQ 3 THEN
       CRT var_1, '+', var_2, '= 3'
    END
