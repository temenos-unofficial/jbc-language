# Dimensioned arrays

Dimensioned arrays use parentheses:

       DIM V.VALUES(30000)            ;* size it
       MAT V.VALUES = 0               ;* assign 0 to all elements
       V.X = SYSTEM(2) - 15  ; V.Y = SYSTEM(3) - 5
       DIM V.SCREEN(V.X, V.Y)         ;* can be 2-dimensional
       V.SCREEN(1, 1) = 123           ;* here goes assignment
