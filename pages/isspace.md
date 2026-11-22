# ISSPACE

The ISSPACE function will check that the expression consists of entirely
space type characters.

## COMMAND SYNTAX

    ISSPACE(expression)

## SYNTAX ELEMENTS

The expression can return a result of any type. The ISSPACE function will
then return TRUE (1) if the expression consists of entirely spacing type
characters. The function will return FALSE (0) if the expression contains
any characters, which are not space characters.

## INTERNATIONAL MODE

When the ISSPACE function is used in International Mode the properties of
each character is determined according to the Unicode Standard.

## EXAMPLE

       a_string = ''             ;  GOSUB CHK.IT    ;*  0
       a_string := ' '           ;  GOSUB CHK.IT    ;*  1
       a_string := CHAR(9)       ;  GOSUB CHK.IT    ;*  1 (TAB)
       a_string := CHAR(10)      ;  GOSUB CHK.IT    ;*  1 (CR)
       a_string := CHAR(11)      ;  GOSUB CHK.IT    ;*  1 (Vertical Tab)
       a_string := CHAR(12)      ;  GOSUB CHK.IT    ;*  1 (Form feed)
       a_string := CHAR(13)      ;  GOSUB CHK.IT    ;*  1 (LF)
    *
       STOP
    *
    CHK.IT:
       CRT ISSPACE(a_string)
       RETURN
    END
