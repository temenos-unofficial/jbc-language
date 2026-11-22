# Numeric variables

       V.VAR = 5            ;   CRT V.VAR           ;* 5
       CRT ISDIGIT(V.VAR)                           ;* 1
       V.VAR = V.VAR + 1    ;   CRT V.VAR           ;* 6
       V.VAR ++             ;   CRT V.VAR           ;* 7
       V.VAR += 1           ;   CRT V.VAR           ;* 8
       V.VAR -= 1           ;   CRT V.VAR           ;* 7
       V.VAR =- 1           ;   CRT V.VAR           ;* -1... easy to make a mistake
       CRT ISDIGIT(V.VAR)                           ;* 0 (we have minus now)
       CLEAR
       CRT V.VAR                                    ;* 0
       V.VAR2 = V.VAR++     ; CRT V.VAR2            ;* 0 - old value of V.VAR
       V.VAR3 = ++V.VAR     ; CRT V.VAR3            ;* 2 - value of V.VAR (1) + 1
    * other operators
       CRT 2 * 3                                    ;* 6
       CRT 2 ** 10                                  ;* power of 2 (1024)
       CRT 2 ^ 10                                   ;* same as above
       CRT 7 / 2                                    ;* 3.5
       CRT SQRT(144)                                ;* 12
    * precedence is quite expected
       CRT 7 / 2 + 3                                ;* 6.5
       CRT 7 / (2 + 3)                              ;* 1.4
    * Dot, plus, minus are considered non-numeric - in all emulations
    * dot_not_numeric = true:
       CRT ISDIGIT(-1)                         ;* 0
       CRT ISDIGIT(1.234)                      ;* 0
