# EXECUTE

The EXECUTE or [PERFORM](https://jbc-lang.org/pages/perform.md) statement allows the currently
executing program to pause and execute any other UNIX/NT program,
including another jBC program or a TAFC command.

## COMMAND SYNTAX

    EXECUTE | PERFORM expression { CAPTURING variable}  \
        { RETURNING | SETTING variable} { PASSLIST {expression}}  \
        { RTNLIST {variable}}{ PASSDATA variable} { RTNDATA variable}

Executes external programs or OS commands;
you can intercept screen output and error messages from any program.
Passes data, dynamic arrays and lists to executed jBC programs.

## SYNTAX ELEMENTS

The PERFORMed expression can be formed from any TAFC construct. The
system will not verify that the command exists before executing it.
Use a new Bourne Shell to execute a command (sh) by default. The shell
type can be changed by preceding the command with a CHAR(255)
concatenated with either "k", "c", or "s" to signify the Korn shell,
C shell or Bourne Shell.

Variables used to pass data to the executed program should have been
assigned to a value before using. You can use any variable name to
receive data.

*CAPTURING variable*

The capturing clause will capture any output that the executing program
would normally send to the terminal screen and place it in the variable
specified. A field mark in the variable replaces every newline normally
sent to the terminal.

*RETURNING variable or SETTING variable*

The returning and setting clauses are identical. Both clauses will
capture the output associated with any error messages the executing
program issues. The first field of the variable will be set to the exit
code of the program.

*PASSLIST variable*

The PASSLIST clause allows TAFC programs to exchange lists or dynamic
arrays between them. The variable should contain the list that the
program wishes to pass to the TAFC program it is executing. The program
to be executed should be able to process lists, otherwise the list will
just be ignored. If the variable name is not specified then the clause
will pass the default select list to the executing program.

*RTNLIST variable*

If the executed program sets up a list then use the RTNLIST clause to
place that list into a specified variable. It places the list in the
default list variable if omitted.

*PASSDATA variable*

Passes the data in the specified variable to another jBC program, the
executing jBC program should retrieve the data using the
[COLLECTDATA](https://jbc-lang.org/pages/collectdata.md) statement.

*RTNDATA variable*

The RTNDATA statement returns any data passed from an executing jBC
program in the specified variable. The executing jBC program should
use the RTNDATA statement to pass data back to the calling program.

## NOTES

The clauses may be specified in any order within the statement but
only one of each clause may exist.

***TAFJ note 1: RTNLIST clause in EXECUTE 'SELECT' doesn't work.***

***TAFJ note 2: RETURNING clause in EXECUTE 'COUNT' doesn't work.***

***TAFJ note 3: EXECUTE of 2 commands delimited with @FM returns code from the first command, not from the second one. Example:***

       EXECUTE 'SELECT F.SPF' :@FM: 'SAVE-LIST spf' CAPTURING output RETURNING ret_code
       CRT CONVERT(@FM:@VM:@SM, '^]\', ret_code)
       *  expected output: 241]1]sel_list]Savelist_msg
       *  output: 404]1]QLNUMSEL

***TAFJ note 4: PASSLIST clause in EXECUTE doesn't work.***

***TAFJ note 5: EXIT() in EXECUTEd program stops the EXECUTing one as well.***

***TAFJ R22 note: EXECUTE 'COMO ON ...' and subsequent CRT statements create COMO file with the printed contents but on subsequent runs file is appended rather than recreated like it is in TAFC (under TAFJ R19 file wasn't even created).***

***Final TAFJ R22 note: use "DOS /c" under Windows or "SH -c" under Linux (keeping the case exactly as it is shown) to execute OS command:***

        EXECUTE 'DOS /c C:\temenos\TAFJ\bin\tShow.bat ACCOUNT' CAPTURING output
        CRT '>>>'
        CHANGE @FM TO CHAR(10) IN output
        CRT output
        INPUT dummy

***TAFJ R19/R23 note: EXECUTE doesn't output anything on the screen. Screen output can be taken via CAPTURING clause (works in R23 but not in R19).***

## EXAMPLE

       V.CMD = 'COUNT .'
       HUSH ON
       EXECUTE V.CMD RETURNING V.CNT
       HUSH OFF
       CRT V.CNT<1,2>     ;* e.g. 15

## EXAMPLE 2

       EXECUTE 'SELECT F.TEMP' :@FM: 'SAVE.LIST TEMP-LIST'

## EXAMPLE 3

       EXECUTE CHAR(255) : 'kecho $SHELL'   ;* /usr/bin/ksh

## EXAMPLE 4

       EXECUTE 'df -m' CAPTURING V.OUTPUT
       LOOP
          REMOVE V.LINE FROM V.OUTPUT SETTING V.STATUS
          CRT '[' : V.LINE : ']'
          IF V.STATUS EQ 0 THEN BREAK
       REPEAT

Sample output of the last example:

<pre>
    [Filesystem    MB blocks      Free %Used    Iused %Iused Mounted on]
    [/dev/hd4         512.00    276.03   47%    12020    16% /]
    [/dev/hd2        5120.00   1398.12   73%    67516    18% /usr]
    [/dev/hd9var      640.00     95.71   86%    13280    36% /var]
    [/dev/hd3         768.00    505.89   35%     8812     7% /tmp]
    [/dev/hd1         128.00    121.68    5%      185     1% /home]
    [/proc                 -         -    -         -     -  /proc]</pre>
