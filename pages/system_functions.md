# System Functions

The following system functions are supported by TAFC:

| Function     | Description                                                              |
|--------------|--------------------------------------------------------------------------|
|SYSTEM(0)     |Returns the last error code                                               |
|SYSTEM(1)     |Returns 1 if output directed to printer                                   |
|SYSTEM(2)     |Returns page width                                                        |
|SYSTEM(3)     |Returns page depth                                                        |
|SYSTEM(4)     |Returns no of lines to print in current page.                             |
|              |(HEADING statement)                                                       |
|SYSTEM(5)     |Returns current page number (HEADING                                      |
|              |statement)                                                                |
|SYSTEM(6)     |Returns current line number (HEADING                                      |
|              |statement)                                                                |
|SYSTEM(7)     |Returns terminal type                                                     |
|SYSTEM(8)     |Returns record length for tape channel 0                                  |
|SYSTEM(9)     |Returns CPU milliseconds                                                  |
|SYSTEM(10)    |Returns 1 if stacked input available                                      |
|SYSTEM(11)    |Returns the number of items in an active select                           |
|              |list or 0 if no list is active                                            |
|SYSTEM(12)    |Returns 1/1000, ( or 1/10 for ROS), seconds past                          |
|              |midnight                                                                  |
|SYSTEM(13)    |Releases time slice                                                       |
|SYSTEM(14)    |Returns the number of characters available in                             |
|              |input buffer. Invoking SYSTEM(14)                                         |
|              |Causes a slight delay in program execution.                               |
|SYSTEM(15)    |Returns bracket options used to invoke command                            |
|SYSTEM(16)    |Returns current PERFORM/EXECUTE level                                     |
|SYSTEM(17)    |Returns stop code of child process                                        |
|SYSTEM(18)    |Returns port number or JBCPORTNO                                          |
|SYSTEM(19)    |Returns login name or JBASICLOGNAME. If the                               |
|              |system_19_timedate emulation option is set then returns                   |
|              |the number of seconds since midnight December 31, 1967.                   |
|SYSTEM(20)    |Returns last spooler file number created                                  |
|SYSTEM(21)    |Returns port number or JBCPORTNO                                          |
|SYSTEM(22)    |Reserved                                                                  |
|SYSTEM(23)    |Returns status of the break key                                           |
|              |                                                                          |
|              |    0 Enabled                                                             |
|              |                                                                          |
|              |    1 Disabled by BASIC                                                   |
|              |                                                                          |
|              |    2 Disabled by Command                                                 |
|              |                                                                          |
|              |    3 Disabled by Command and BASIC                                       |
|              |                                                                          |
|SYSTEM(24)    |Returns 1 if echo enabled, 0 if echo disabled                             |
|SYSTEM(25)    |Returns 1 if background process                                           |
|SYSTEM(26)    |Returns current prompt character                                          |
|SYSTEM(27)    |Returns 1 if executed by PROC                                             |
|SYSTEM(28)    |Reserved.                                                                 |
|SYSTEM(29)    |Reserved.                                                                 |
|SYSTEM(30)    |Returns 1 if paging is in effect (HEADING statement)                      |
|SYSTEM(31)    |Reserved                                                                  |
|SYSTEM(32)    |Reserved                                                                  |
|SYSTEM(33)    |Reserved                                                                  |
|SYSTEM(34)    |Reserved                                                                  |
|SYSTEM(35)    |Returns language in use as a name or number (ROS)                         |
|SYSTEM(36)    |Reserved                                                                  |
|SYSTEM(37)    |Returns thousands separator                                               |
|SYSTEM(38)    |Returns decimal separator                                                 |
|SYSTEM(39)    |Returns money symbol                                                      |
|SYSTEM(40)    |Returns program name                                                      |
|SYSTEM(41)    |Returns release number                                                    |
|SYSTEM(42)    |Reserved                                                                  |
|SYSTEM(43)    |Returns port number of item lock                                          |
|SYSTEM(44)    |Returns 99 for jBASE system type                                          |
|SYSTEM(45)    |Reserved                                                                  |
|SYSTEM(47)    |Returns 1 if currently in a transaction                                   |
|SYSTEM(48)    |Reserved                                                                  |
|SYSTEM(49)    |Returns PLID environment variable                                         |
|SYSTEM(50)    |Returns login user id                                                     |
|SYSTEM(51)    |Reserved                                                                  |
|SYSTEM(52)    |Returns system node name                                                  |
|SYSTEM(53)    |Reserved                                                                  |
|SYSTEM(100)   |Returns program create information                                        |
|SYSTEM(101)   |Returns port number or JBCPORTNO                                          |
|SYSTEM(102)   |Reserved                                                                  |
|SYSTEM(1000)  |Returns command line separated by attribute marks                         |
|SYSTEM(1001)  |Returns command line and options                                          |
|SYSTEM(1002)  |Returns temporary scratch file name                                       |
|SYSTEM(1003)  |Returns terminfo Binary definitions                                       |
|SYSTEM(1004)  |Returns terminfo Integer definitions                                      |
|SYSTEM(1005)  |Returns terminfo String definitions                                       |
|SYSTEM(1006)  |Reserved                                                                  |
|SYSTEM(1007)  |Returns system time                                                       |
|SYSTEM(1008)  |Returns SYSTEM file path                                                  |
|SYSTEM(1009)  |Returns MD file path                                                      |
|SYSTEM(1010)  |Returns Print Report information                                          |
|SYSTEM(1011)  |Returns jBASE release directory                                           |
|              |path. TAFC_HOME                                                           |
|SYSTEM(1012)  |Returns jBASE global directory                                            |
|              |path. JBCGLOBALDIR                                                        |
|SYSTEM(1013)  |Returns memory usage (UNIX only):                                         |
|              |                                                                          |
|              |<1> Free memory small blocks                                              |
|              |                                                                          |
|              |<2> Free memory large blocks                                              |
|              |                                                                          |
|              |<3> Used memory small blocks                                              |
|              |                                                                          |
|              |<4> Used memory large blocks                                              |
|SYSTEM(1014)  |Returns relative PROC level                                               |
|SYSTEM(1015)  |Returns effective user name. LOGNAME                                      |
|SYSTEM(1016)  |Returns tape assignment information                                       |
|SYSTEM(1017)  |Returns platform. UNIX, WINNT or WIN95                                    |
|SYSTEM(1018)  |Returns configured processors                                             |
|SYSTEM(1019)  |Returns system information (uname -a)                                     |
|SYSTEM(1020)  |Returns login user name                                                   |
|SYSTEM(1021)  |TAFC release information:                                                 |
|              |                                                                          |
|              |<1> Major release number                                                  |
|              |                                                                          |
|              |<2> Minor release number                                                  |
|              |                                                                          |
|              |<3> Patch level                                                           |
|              |                                                                          |
|              |<4> Copyright information                                                 |
|SYSTEM(1022)  |Returns the status of TAFC profiling:                                     |
|              |                                                                          |
|              | 0   no profiling is active                                               |
|              |                                                                          |
|              | 1   full profiling is active                                             |
|              |                                                                          |
|              | 2   short profiling is active                                            |
|              |                                                                          |
|              | 3   jCOVER profiling is active                                           |
|              |                                                                          |
|SYSTEM(1023)  |Used by STATUS() function                                                 |
|SYSTEM(1024)  |Retrieves details about last signals                                      |
|SYSTEM(1025)  |Returns value of International mode for thread                            |
|SYSTEM(1026)  |Total amount of memory in use formatted with                              |
|              |commas                                                                    |
|SYSTEM(1027)  |Returns directory PROC; Used by WHERE, LISTU                              |
|              |Information about running processes can be obtained                       |
|              |via the PROC jedi....                                                     |
|              |This JEDI enables retrieval of information from                           |
|              |executing processes and is the interface now used                         |
|              |by the WHERE command...                                                   |
|              |                                                                          |
|              |                                                                          |
|              | OPEN SYSTEM(1027) TO PROC ELSE STOP 201, "PROC"                        |
|              |            SELECT PROC TO Sel                                          |
|              |             LOOP                                                       |
|              |    WHILE READNEXT key FROM Sel DO                                      |
|              |  READ ProcessRecord FROM PROC, key ELSE CRT "Read Error"; STOP         |
|              |            REPEAT                                                      |
|              |                                                                          |
|              |Info for current user can be returned from the                            |
|              |@USERSTATS variable.                                                      |
|              |                                                                          |
|              |Attribute descriptions for Process Records returned                       |
|              |from the PROC Jedi READ interface.                                        |
|              |                                                                          |
|              | <1>   Port number                                                        |
|              | <2>   Number of programs running                                         |
|              | <3>   Connect time                                                       |
|              | <4>   Process ID                                                         |
|              | <5>   Account name                                                       |
|              | <6>   User name                                                          |
|              | <7>   Terminal name in TAFC format                                       |
|              | <8>   Terminal name in UNIX format                                       |
|              | <9>   Database name                                                      |
|              | <10>  Name of the tty device                                             |
|              | <11>  Language name                                                      |
|              | <12>  Time listening thread executed                                     |
|              | <13>  Mallinfo memory free                                               |
|              | <14>  Mallinfo memory used                                               |
|              | <15>  Type of thread as a number                                         |
|              | <16>  Type of thread as a string WHERE                                   |
|              |                                                                          |
|              |           thread_type_string = "Normal" =1                               |
|              |           thread_type_string = "javaOBjEX" = 2                           |
|              |           thread_type_string = "vbOBjEX" = 3                             |
|              |	       thread_type_string = "jrfs" = 4                            |
|              |           thread_type_string = "Compiler" = 5                            |
|              |           thread_type_string = "jdp" = 6                                 |
|              |           thread_type_string = "Listen" = 7                              |
|              |           thread_type_string = "Daemon"= 8                               |
|              |           thread_type_string = "Admin"                                   |
|              |           thread_type_string = "jrla"                                    |
|              |                                                                          |
|              |<17> Number of instructions executed and licenses allocated to work       |
|              |                                                                          |
|              |     around a bug in Windows. Need to build the buffer in                 |
|              |     separate sprintf's                                                   |
|              |<18> Number of OPEN's                                                     |
|              |<19> Number of READ's                                                     |
|              |<20> Number of WRITE's                                                    |
|              |<21> Number of DELETE's                                                   |
|              |<22> Number of CLEARFILE's                                                |
|              |<23> Number of EXECUTE's                                                  |
|              |<24> Number of INPUT's                                                    |
|              |<25> UNUSED                                                               |
|              |<26>  Number of files the application thinks is open                      |
|              |<27> Number of files that in reality are opened by the OS                 |
|              |<28> Application data set by @USER.ROOT                                   |
|              |<29> Text String to identify process                                      |
|              |<41> Command line arguments < threadnext >                                |
|              |<42> Current Line Number  < threadnext >                                  |
|              |<43> Name of source  <threadnext >                                        |
|              |<44> Status as a text string < threadnext >                               |
|	       |                       status = "Program running normally"                |
|              |                                                                          |
|              |                   status = "Program is SLEEPING"                         |
|              |                                                                          |
|              |                   status = "Program in DEBUGGER"                         |
|              |                                                                          |
|              |                   status = "Program at keyboard INPUT"                   |
|              |                                                                          |
|              |                   status = "Program blocked on record LOCK"              |
|              |                                                                          |
|              |                   status = "Program is doing EXECUTE/PERFORM"            |
|              |                                                                          |
|              |                   status = "Error!! Status unknown"                      |
|              |<47> Status as an integer  <threadnext >                                  |
|              |<48> User CPU time <threadnext >                                          |
|              |<49> System CPU time <threadnext >                                        |
|              |<50> Child User CPU time <threadnext >                                    |
|              |<51> Child System CPU time <threadnext >                                  |
|              |<52> User defined thread data <threadnext >                               |
|              |                                                                          |
|SYSTEM(1028)  | Logged in database name                                                  |
|SYSTEM(1029)  | Shows the CALL stack history so that in error conditions the             |
|              | application, such as database I/O statistics, programs                   |
|              | being performed and so on.  Can be used with @USERDATA.    |
|SYSTEM(1030)  | This new entry into the SYSTEM() function returns the current            |
|              | perform level in the range 1 to 32. This is similar                      |
|              | to SYSTEM(16), which returns the nested execute level.    |
|              | The difference is that SYSTEM(16) does not include any procs,               |
|              | paragraphs or shells and returns the relative  |
|              | application program level.                                                                         |
|              | SYSTEM(1030) returns the relative program level including                        |
|              |  all the proc interpreters, paragraph interpreters and    |
|              | shells.                                                                  |
|SYSTEM(1031)  | Number of free bytes on the current file system                          |
|SYSTEM(1032)  | Returns default frame size                                               |
|SYSTEM(1034)  | Returns handle of the current thread                                     |
|SYSTEM(1035)  | Returns the product ID of the license currently in use   |
|              |  by this process;     |
|              |  1    Enterprise                                                         |
|              |  13.  Server                                                             |

***TAFJ note 1: Non-working ones: SYSTEM(14), SYSTEM(16), SYSTEM(26), SYSTEM(101), SYSTEM(1000), SYSTEM(1001), SYSTEM(1018), SYSTEM(1026), SYSTEM(1030).***

***TAFJ note 2: SYSTEM(1027) shows only current process.***

***TAFJ R22 note: SYSTEM(1000), SYSTEM(1001), SYSTEM(1018) and SYSTEM(1026) were fixed.***

***TAFJ R22 note 2: SYSTEM(2) and SYSTEM(3) now return 0 (returned 120 and 50 respectively under TAFJ R19).***

***TAFJ R23 note: SYSTEM(1000) and SYSTEM(1001) weren't probably fixed in TAFJ R22 (unable to verify it now) - in TAFJ R23 they return a string, not a dynamic array.***

## EXAMPLES

       CRT SYSTEM(40)        ;* e.g. test
    * is there anything in keyboard buffer
       CRT SYSTEM(14)        ;*  0
    * Buffer is not necessarily filled manually
       DATA 'QWE'
       CRT SYSTEM(14)        ;*  4
    * Prompt...
       CRT SYSTEM(26)        ;*  ?
       PROMPT 'Your choice:'
       CRT SYSTEM(26)        ;*  Your choice:
    * Active SELECT
       IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       CLEARDATA             ;* otherwise "QWE" will be executed
       CRT SYSTEM(11)        ;*  0
       HUSH ON
       EXECUTE 'SELECT ' : V.HOME : '/jbcmessages'
       HUSH OFF
       CRT SYSTEM(11)        ;*  490
