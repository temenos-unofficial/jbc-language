# JBASECOREDUMP

JBASECOREDUMP is used as a diagnostic tool for applications. It allows
a snapshot of the application to be dumped to an external file for later
analysis.

- The JBASECOREDUMP function will stop the execution of a jbc program or subroutine.
- The applications snapshot is also saved in the logs.
- The filename for the external file will always be unique.
- If called via jAgent an exception will be thrown.

## COMMAND SYNTAX

    JBASECOREDUMP(expression1, expression2)

## SYNTAX ELEMENTS

**expression1** should evaluate to a string:

If assigned a value, expression1 will be used as the extension for the external
text file created to hold execution snapshot.

    rc = JBASECOREDUMP('SERVICE', 0)

This will create the file with name structured as:

"JBASECOREDUMP.&lt;&lt;UUID&gt;&gt;.&lt;&lt;expression1&gt;&gt;",
e.g.:

<pre>
    JBASECOREDUMP.a57d07cc-6539-470f-9959-24ed7c715f4f.SERVICE.</pre>

If a null string is used:

    rc = JBASECOREDUMP('', 0)

This will create the file with name structured as:

"JBASECOREDUMP.&lt;&lt;UUID&gt;&gt;,
e.g.:

<pre>
    JBASECOREDUMP.a57d07cc-6539-470f-9959-24ed7c715f4f</pre>

**expression2** should evaluate to a numeric integer:

<pre>
    0: Add all varables to the external text file.
    1: Suppess any UNASSIGNED varables saved to the external file.</pre>

## NOTES

jBC functionality will be affected in the following areas:

- Calling from a jbc subroutine.
- Running a program in a jsh.
- External text filenames are now unique for coredump files.
- Calling process started via EXECUTE/PERFORM from within a jbc program.
- When called via jAgent, using a jbc subroutine.

*Calling from a jbc subroutine.*

When the JBASECOREDUMP function is called from a jbc program it will stop execution.
The call stack is saved to a file, and also saved to the logs.
Each core dump now is assigned a unique ID.

*Running a program in a jsh.*

If called from a program while in a jSH, a message is now displayed along
with the UUID for the core dump, you can use this to locate the stack trace
in the logs.

<pre>
    &lowast;&lowast; Error [ JBASECOREDUMP ] &lowast;&lowast; Program Aborted, Coredump UUID: &lt;&lt;UUID&gt;&gt;</pre>

*Calling process started via EXECUTE/PERFORM from within a jbc program.*

If JBASECOREDUMP is called from a process started via EXECUTE/PERFORM from a
jbc program, use RETURNING/SETTING to capture the output associated with any
error messages the executing program issues.

    EXECUTE "MYPROGRAM" CAPTURING junk SETTING rc
         * rc<1,1> holds the error code "JBASECOREDUMP".
         * rc<1,2> holds the UUID for the core dump.

Because all JBASECOREDUMP's are logged you can use this UUID to check the log files.

*When called via jAgent, using a jbc subroutine.*

A new exception type has been created to return the UUID to the client
application. (JSubroutineCoreDumpException)

The following is a simple example of how to check for core dumps.

<pre>
    try {
      _connection.call("CALLCOREDUMP_WITH_FILENAME", null);
    }
    catch (const JSubroutineCoreDumpException &e) {
      const std::string uuid = e.getMessage()->c_str();
      // handle exception
    }</pre>

Use this UUID to check on the server for what went wrong.
The Java and C# clients have also been updated to handle this new exception
type.

## EXAMPLE

example.b:

    001 rc = JBASECOREDUMP('ERRORFILE', '')

Compile:

<pre>
    jcompile example.b</pre>

run:

<pre>
    &lowast;&lowast; Error [ JBASECOREDUMP ] &lowast;&lowast; Program Aborted,
    Coredump UUID: 4d5a252a-c009-4aec-9e1f-73d3251c6b81</pre>

<pre>
     dir JBASECOREDUMP&lowast;
    JBASECOREDUMP.4d5a252a-c009-4aec-9e1f-73d3251c6b81.ERRORFILE</pre>

<pre>
    ct . JBASECOREDUMP.4d5a252a-c009-4aec-9e1f-73d3251c6b81.ERRORFILE
    JBASECOREDUMP.4d5a252a-c009-4aec-9e1f-73d3251c6b81.ERRORFILE
    001 jBASE Core dump created at Fri Feb 24 11:21:10 2012
    002 UUID: 4d5a252a-c009-4aec-9e1f-73d3251c6b81
    003 Program example , port 87 , process id 3488
    004
    005 CALL/GOSUB stack
    006
    007 Backtrace:
    008 #0: jmainfunction.b:1
    009 #1: example.b:1 -> Line 1 , Source jmainfunction.b
    010
    011 Backtrace log:
    012 Program jmainfunction.b, Line 1, Stack level 0
    013 Line 0 , Source jmainfunction.b , Level 0
    014 >>> Program example.b, Line 1, Stack level 1
    015 Line 1 , Source jmainfunction.b
    016
    017 All the defined VAR's in the program
    018
    019 SUBROUTINE main()
    020 00000000006BEE90 : rc : (V) String : 0 bytes at address 0000000055740A58 :</pre>

Locating entry in the logs using the UUID.

<pre>
    find "4d5a252a-c009-4aec-9e1f-73d3251c6b81" %TAFC_HOME%\log\default</pre>

The following lines may appear in the log file:

<pre>
    ---- C:\R12\LOG\DEFAULT\EXAMPLE.HML0001.JBCUSER.LOG.ERROR.20120224-112110.3488
    E0224 11:21:10.737900 5832 tafc_logger_c_api.cpp:33]
    Coredump file: JBASECOREDUMP.4d5a252a-c009-4aec-9e1f-73d3251c6b81.ERRORFILE
    E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    UUID: 4d5a252a-c009-4aec-9e1f-73d3251c6b81</pre>

Type the following command to display the log file:

<pre>
    CT %TAFC_HOME%\LOG\DEFAULT\EXAMPLE.HML0001.JBCUSER.LOG.ERROR.20120224-
       112110.3488</pre>

The below log file will appear "example.HML0001.JBCUSER.LOG.ERROR.20120224-112110.3488":

<pre>
    001 Log file created at: 2012/02/24 11:21:10
    002 Running on machine: HML0001
    003 Log line format: [IWEF]mmdd hh:mm:ss.uuuuuu threadid file:line] msg
    004 E0224 11:21:10.737900 5832 tafc_logger_c_api.cpp:33] Coredump file:
        JBASECOREDUMP.4d5a252a-c009-4aec-9e1f-73d3251c6b81.ERRORFILE
    005 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] jBASE Core dump created
        at Fri Feb 24 11:21:10 2012
    006 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] UUID:
        4d5a252a-c009-4aec-9e1f-73d3251c6b81
    007 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Program example , port
        87, process id 3488
    008 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    009 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] CALL/GOSUB stack
    010 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    011 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Backtrace:
    012 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] #0: jmainfunction.b:1219
    013 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] #1: example.b:1->Line 1,
        Source jmainfunction.b
    014 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    015 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Backtrace log:
    016 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Program jmainfunction.b,
        Line 1, Stack level 0
    017 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Line 0 ,
        Source jmainfunction.b , Level 0
    018 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] >>> Program example.b,
        Line 1, Stack level 1
    019 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] Line 1 ,
        Source jmainfunction.b
    020 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    021 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] All the defined VAR's
        in the program
    022 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33]
    023 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] SUBROUTINE main()
    024 E0224 11:21:10.739899 5832 tafc_logger_c_api.cpp:33] 00000000006BEE90 :
        rc : (V) String : 0 bytes at address 0000000055740A58 :</pre>
