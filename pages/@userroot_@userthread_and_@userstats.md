# @USER.ROOT, @USER.THREAD and @USERSTATS

The use of the @USER.ROOT command allows a jBC program to store and
retrieve a string of up to 63 bytes that is unique to that user. The
intention is to really "publish" information that other programs can
find.

## For example:

       @USER.ROOT = "Temenos T24 Financials"
       .....
       PRINT "root user declaration is" : @USER.ROOT

See attribute &lt;28&gt;, USER_PROC_USER_ROOT, in the section
"Layout of user record"

The @USER.THREAD is similar except a value exists for each PERFORM
level. So one program can set/retrieve it but if the program does a
PERFORM of a second program then the second program gets a different
set of values.

See attribute &lt;52&gt;, USER_PROC_USER_THREAD, in the section "Layout of user
record"

The @USERSTATS allows a program to retrieve all sorts of miscellanous
information about itself. For example if a program wants to find out
how many database I/O's it performed it could do this:

    INCLUDE JBC.h
       info1 = @USERSTATS
       read1 = info1<USER_PROC_STATS_READ>
       EXECUTE 'COUNT fb1 WITH *A1 EQ "x"'
       info2 = @USERSTATS
       read2 = info2<USER_PROC_STATS_READ>
       PRINT "The COUNT command took " : (read2-read1) : " READs from the database"

So a program can set a user-definable string to whatever value it likes,
up to 63 bytes, and other programs can use various methods (see "User
Information Retrieval" below) to access this data.

## User Information Retrieval

There are 3 ways of finding information about one or more users on a
TAFC system:

1. Using the @USER.ROOT, @USER.THREAD and @USERSTATS variables in your jBC
   code you can find information about yourself. You cannot find
   information about other users.

2. The "WHERE (V" command can be used to display the @USER.ROOT and
   @USER.THREAD data for specified users.

3. Using some jBC code you can find out lots of information about each
   user on the system. This is exactly the mechanism that the WHERE
   command uses. For example to display all users logged on you could
   write this.

## Example:

    INCLUDE JBC.h
       * Open the special jEDI file to access the user information.
       OPEN SYSTEM(1027) TO PROC ELSE STOP 201,SYSTEM(1027)
       SELECT PROC
       * For each user logged on read in their user information
       LOOP WHILE READNEXT key DO
           READ rec FROM PROC, key THEN
              PRINT "Port " : rec<USER_PROC_PORT_NUMBER> :   \
                 " is logged on by user " : rec<USER_PROC_ACCOUNT>
          END
       REPEAT

## Layout of user record

The information retrieved by either the READ in the above example
or the  @USERSTATS is the same and is as follows.

The first 40 attributes are data attributes that correlate to the
entire   user. Attributes 41 onwards are multi-valued and have one
value per program being PERFORM'ed by that user

All the numbers below can be replaced by symbolic references in
JBC.h, look for those that begin from "USER\_PROC\_".

&lt;1&gt; The port number

&lt;2&gt; The number of programs running in this port.

&lt;3&gt; Time the user started in Universal Co-ordinated Time or UTC (not a
 dyslexic mistake). This is raw UNIX time. You can convert this to TAFC
 internal time format using the U0FF0 conversion or to internal date
 format using the U0FF1 conversion.

&lt;4&gt; The process ID

&lt;5&gt; Account name

&lt;6&gt; User name. Normally the operating system name.

&lt;7&gt; Terminal name in TAFC format

&lt;8&gt; Terminal name in Operating system format.

&lt;9&gt; Database name

&lt;10&gt; TTY device name

&lt;11&gt; Language name.

&lt;12&gt; Time in UTC the listening thread last found the thread alive.

&lt;13&gt; Amount of heap space memory in free space chain on a process wide
basis. Not real-time, only updated every 15 seconds.

&lt;14&gt; Amount of heap space memory in use on a process wide basis. Not
real-time , only updated every 15 seconds

&lt;15&gt; Thread type as an internal integer.

&lt;16&gt; Type of thread as a text string.

&lt;17&gt; License counters

&lt;18&gt; Number of OPENs performed.

&lt;19&gt; Number of READs performed.

&lt;20&gt; Number of WRITE's performed.

&lt;21> Number of DELETE's performed

&lt;22> Number of CLEARFILE's performed

&lt;23> Number of PERFORM/EXECUTE's performed.

&lt;24> Number of INPUT's performed.

&lt;25> Not used.

&lt;26> Number of jBASE files the application thinks it has open at the
moment.

&lt;27> Number of jBASE files actually opened by the operating system
at the moment.

&lt;28> Any data set by the application using @USER.ROOT

&lt;29> Process Identifier. A string created by the operating system to
identify the process. It is O/S specific. Currenly on IBM i-series
platform only.

&lt;30> to &lt;40> Reserved.

Attributes 41 onward are multi-valued, one value per perform level,
and there are &lt;2> perform levels active.

&lt;41,n> Program name and command line arguments.

&lt;42,n> The line number in jBC the program is currently executing.

&lt;43,n> The source name in jBC the program is currently executing.

&lt;44,n> Not used.

&lt;45,n> Not used.

&lt;46,n> Status of program execution as a readable text string.

&lt;47,n> Status of program execution as an internal integer.

&lt;48,n> User CPU time . Depending upon the hardware this will be either
for the entire process or just the single thread.

&lt;49,n> System CPU time. Depending upon the hardware this will be either
for the entire process or just the single thread.

&lt;50,n> User CPU time used by any external child processes it might have
spawned.

&lt;51,n> System CPU time used by any external child processes it might
have spawned.

&lt;52,n> Any data set by the application using @USER.THREAD
