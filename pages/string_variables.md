# String variables

Strings can be delimited with single quotes, double quotes or backslashes:

       CRT 'QWERTZ'    ;* this is a string
       CRT "QWERTZ"    ;* this is also a string
       CRT 'QWE"RTZ'   ;* and even this is a string
       CRT \QWERTZ\    ;* still this is a string
       * and here a backslash means line continuation
       CRT 'QWE'  \
          : 'RTZ'

To concatenate strings (you could see it in one of examples above), use a
colon:

       a_line = 'QWE' : 'RT'
       CRT a_line                               ;*  QWERT
       * unary concatenation
       a_line := 'Y'
       CRT a_line                               ;*  QWERTY

String can be concatenated with a number without explicit conversion:

       a_line = 'QWERTY'
       a_line := 123
       CRT a_line                               ;*  QWERTY123

To extract a substring from a string use square brackets:

       a_line = 'QWERTY'
       CRT a_line[1,2]                          ;*  QW
       CRT a_line[2]                            ;*  TY
       CRT a_line[-4,2]                         ;*  ER

It's possible to reassign parts of a string using that notation:

       a_string = 'ABC'
       a_string[2,1] = 'Q'
       CRT a_string                             ;* AQC
       a_string[2,1] = 'WER'
       CRT a_string                             ;* AWERC

Strings comparison is done from left to right:

       a_string = 'ABC'
       char_a = 'A'
       char_b = 'B'
       CRT a_string GT char_a       ;* 1
       CRT a_string GT char_b       ;* 0

Other common string operations:

       a_line = 'QWERTY'
       * add quotes around a string
       CRT SQUOTE(a_line[4,999])                ;*  'RTY'
       CRT QUOTE(a_line)                        ;*  "QWERTY"
       * change case
       CRT DOWNCASE(a_line)                     ;*  qwerty
       CRT UPCASE('do it now!')                 ;*  DO IT NOW!
       * get length of a string
       CRT LEN(a_line)                          ;*  6
       * get length of i18n string - number of characters and number of bytes
       a_line := CHAR(353)
       CRT LEN(a_line)                          ;*  7
       CRT BYTELEN(a_line)                      ;*  8
       * repeat string several times
       CRT STR('QWE', 5)                        ;*  QWEQWEQWEQWEQWE
       * dynamic array is also a string
       dyn_array = 'qwe' : @FM : "rty" : @VM : \xYZ\
       CRT LEN(dyn_array)                       ;*  11
       CRT FMT( UPCASE(dyn_array), 'MCP' )      ;*  QWE^RTY]XYZ
       * pad a string
       a_string = 'AWERC'
       CRT '/' : FMT(a_string, '25R') : '/'     ;* /                    AWERC/
       * get ASCII value of a character
       CRT SEQ(a_string[1,1])                   ;* 65 (ASCII code of "A")
