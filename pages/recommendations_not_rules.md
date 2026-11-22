# Recommendations (not rules)

*Note: some examples in this documentation don't fully follow these rules - they were taken from other sources or it's done intentionally to illustrate some language features.*

- All variables are to be in lower case and in the lower_case_and_underscore_naming style.

- Use only one style of quotes for strings, e.g.: "QWERT" (double quotes, preferable) or 'QWERT' (single quotes). Mix them only if it's really required, e.g.:

       CRT '"Yes Minister", ' : "that's what I said."

- Always use one space after the comma and never before the comma.

- Never use space after '(' and before ')' (exception is when code is more readable with it).

- Never put multiple commands on a single line and separate them by ";", except for short similar statements, like:

       var_1 = 1  ;  var_2 = 2  ;  var_3 = 3

- Don't put trailing ';' at the end of the lines.

- Never convert ints to boolean implicitly:

Instead of:

       IF INDEX(...) THEN

always write:

       IF INDEX(...) NE 0 THEN

Same goes for strings. Instead of:

       var = 'ABC'
       IF var THEN  ;* code continues here

Use:

       IF var NE '' THEN  ;* code continues here

- Never hardcode program or subroutine name in error messages etc. Use SYSTEM(40) instead.

- Always supply meaningful error messages with sufficient additional information.

- Don't comment what you do; comment why.

- Don't mix tabs with spaces, use either former or latter.

- Don't use characters with ASCII code above 126 in the source. To form strings with such characters use CHAR() or load them from external file or table.

- Use CR (ASCII 10) for line ends rather than CR+LF.

- For statements like INCLUDE, $INSERT use zero indent; for all other code - 3 spaces of initial indent and 3 spaces to indent each FOR...NEXT, LOOP...REPEAT contents etc.

- Wrap lines that are longer than 80 characters (use a backslash or comma at the end where the latter is applicable). It's a good idea to move line continuation(s) even more than 3 positions to the right, e.g.:

       current_date = DATE()
       current_day = OCONV(current_date, 'DD')
       current_month = OCONV(current_date, 'DM')
       ansi_date =  OCONV(current_date, 'DY') : '-'    \
             : FMT(current_month, 'R0%2' )   : '-'     \
             : FMT(current_day, 'R0%2' )
       CRT ansi_date                             ;* e.g. 2013-03-08

- Use spaces around "=":  not "var=1" but "var = 1".

- Use "=" for assignment only; for comparisons use "EQ".

- Don't use IF..ELSE without THEN.

- Avoid GOTO, RETURN TO as much as possible.

- Use named COMMON rather than unnamed.

- Don't use numeric line labels like:

       001 A = 0
       002 A += 1
       003 IF A LT 5 THEN GOTO 002 ELSE CRT A

- Avoid ambiguity with IF...AND...OR, use parentheses. In the following example code lines 2, 3 and 4 are the same (except parentheses); only second IF is true:

       var_1 = 1  ; var_2 = 2  ; var_3 = 3 ; var_4 = 4
       IF var_1 EQ 1 OR var_2 EQ 20 AND var_3 EQ 30 OR var_4 EQ 40 THEN CRT 1
       IF var_1 EQ 1 OR (var_2 EQ 20 AND var_3 EQ 30 OR var_4 EQ 40) THEN CRT 2
       IF (var_1 EQ 1 OR var_2 EQ 20) AND (var_3 EQ 30 OR var_4 EQ 40) THEN CRT 3

- Use only one method of writing "not equal" (preferably "NE").

(See the second example in chapter ["Other notes"](https://jbc-lang.org/pages/other_notes.md).)
