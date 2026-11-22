# EMBEDDED SQL COMPILER OPTION

In order to compile jBC programs containing Embedded SQL statements the
TAFC compiler option "Jq" must be invoked with the jBC compiler command.
The "Jq" option also expects an SQL implementation specifier, as
described below.

|-Jq<type>  |  RDBMS                                 |
|-----------|----------------------------------------|
|  d        |  IBM DB2                               |
|  m        |  Microsoft SQL Server (Windows only)   |
|  o        |  Oracle                                |
|  I        |  Ingres                                |
|  S        |  Sybase                                |
|  X        |  Informix                              |

e.g. To compile the jBC example program PartEntry.b for an Oracle SQL
implementation database.

<pre>
    jcompile -Jqo PartEntry.b</pre>

In this example the SQL specifier is "o" for Oracle. Other specifiers
are added as and when Embedded SQL implementations are required. e.g.
The "i" option informs the TAFC compiler to invoke mechanisms for the
Ingres Embedded SQL implementation. Although the Embedded SQL standard
is the same, each SQL provider requires different manipulative
techniques in order to compile and connect to the database.

The jcompile compiler pre-processes the jBC program parsing the normal
jBC and Embedded SQL statements to produce an intermediate C program.
The SQL implementation dependent pre-processor is then invoked to
convert the Embedded SQL statements to the implementation defined
internal functions. The resulting program is then compiled and linked.
The jBC compilation should be executed in an user account which has
been enabled for the required Embedded SQL implementation. Attempting
to compile in an account not enabled for the required SQL
implementation may cause compilation failure as certain environment
variables for the implementation may not have been modified for
the correct directory paths, etc.
