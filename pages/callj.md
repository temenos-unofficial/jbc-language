# CALLJ

The CALLJ command allows BASIC to call a Java method. CALLJ is useful
when using third party applications offering a Java API (for example,
publish and subscribe, messaging, etc.)

## COMMAND SYNTAX

    CALLJ packageAndClassName, [$]methodName, param SETTING ret  \
          [ON ERROR] errStatment

In order to use CALLJ, you need:

- A Java virtual machine
- CLASSPATH environment variable set to point on the class you want to
  invoke

## NOTES

The Java virtual machine is loaded dynamically at runtime, so a
compiled basic application has no dependencies on any Java virtual
machine. By default, the program will search for:

jvm.dll on Windows platforms

libjvm.sl on HP UNIX

libjvm.so for other platforms

Although it is not usually necessary, it is possible to specify a Java
library by setting the JBCJVMLIB environment variable:

Windows:
set JBCJVMLIB=jvm.dll
AIX:
export JBCJVMLIB=libjvm.so

## PERFORMANCE CONSIDERATIONS

The first call to CALLJ carries the overhead of loading the Java
Virtual Machine into memory. Subsequent calls do not have this overhead.
Many additional threads will be created and used by the JVM.

In addition, calls to non static methods carry the overhead of calling
the constructor for the class. Wherever possible, static methods should
be used.

## SYNTAX ELEMENTS

**packageAndClassName** The "full" class name
(e.g., com.jbase.util.utilClass)

**methodName** The name of the Java method in this class
(e.g., "myMethod")

NOTE: If the method is static, you must append a dollay symbol ( $ ) before the name.
It will be removed from the method name before calling it.

**Param** Any parameter (eg DynArray)

## EXAMPLE

In Java:

<pre>
    package mypackage;
//
    public class mytestclass {
        static int i = 0;
        private mytestclass() {
        }
//
        public String mymethod(String s) {
	        return ( "Java Received : " + s ) ;
        }
//
        public static String mystaticmethod(String s) {
  		    i++;
  		    return s + " "  + i;
        }
    }</pre>

To call these methods from jBC:

    CALLJ 'mypackage.mytestclass', 'mymethod', p SETTING ret
    CRT ret
    CALLJ 'mypackage/mytestclass', '$mystaticmethod', p SETTING ret
    CRT ret

## ON ERROR

Use the SYSTEM(0) variable to manage any errors at the BASIC level,
which occur during the call.

This variable can have the following values:

|Value |  Description                  |
|------|-------------------------------|
| 1    | Fatal error creating thread   |
| 2    | Cannot create JVM             |
| 3    | Cannot find class             |
| 4    | Unicode conversion error      |
| 5    | Cannot find method            |
| 6    | Cannot find object constructor|
| 7    | Cannot instantiate object     |

## EXAMPLE

jBC code using the ON ERROR will look like this:

    PROGRAM testcallj
         className = ''
         methodName = ''
         param = ''
         CRT "Please enter a Class Name " :  ;   INPUT className
         CRT "Please enter a Method Name " :  ;  INPUT methodName
         CRT "Please enter a Parameter : "  ; INPUT param
         CALLJ className,methodName, param SETTING ret ON ERROR GOTO errHandler
         CRT "Received batch from Java : " : ret
    RETURN
    *
    errHandler:
         err = SYSTEM(0)
         IF err = 2 THEN
              CRT "Cannot find the JVM.dll !"
              RETURN
         END
         IF err = 3 THEN
              CRT "Class " : className : "doesn't exist !"
              RETURN
         END
    *
         IF err = 5 THEN
      	      CRT "Method " : methodName : "doesn't exist !"
              RETURN
         END
    END

The CALLJ function provides access to a JavaVM from within the BASIC
environment. For it to be able to start a JavaVM (JVM) the
environment needs to know where the JVM is located. Specifically it
needs to know where certain libraries are located.

**WINDOWS**

Windows: looking for 'jvm.dll'

Add "c:\jdk1.6.0_33\jre\bin\server" to the PATH environment variable.

A generic format might be  %JDKDIR%\jre\bin\server.

UNIX

For UNIX it is possible to configure generic symbolic links to make
profiles portable.

Location of JDK	export JDKDIR=/opt/java6

Symbolic link for JRE libs			/opt/java6/jrelib

Symbolic link for JVM library		/opt/java6/jvmlib

Linux

	 /opt/java6/jrelib   -> /opt/java6/jre/lib/amd64

	 /opt/java6/jvmlib   -> /opt/java6/jre/lib/amd64/server

.profile:

Add "/opt/java6/jrelib:/opt/java6/jvmlib" to the LD_LIBRARY_PATH

HP-UX

	 /opt/java6/jrelib   -> /opt/java6/jre/lib/IA64W

	 /opt/java6/jvmlib   -> /opt/java6/jre/lib/IA64W/server

	 .profile:

Add "/opt/java6/jrelib:/opt/java6/jvmlib" to the SHLIB_PATH

AIX (IBM JDK)

	 /opt/java6/jrelib   -> /opt/java6/jre/bin

	 /opt/java6/jvmlib   -> /opt/java6/jre/bin/classic

	 .profile:

Add "/opt/java6/jrelib:/opt/java6/jvmlib" to the LIBPATH

Solaris SPARC

	 /opt/java6/jrelib   -> /opt/java6/jre/lib/sparc

	 /opt/java6/jvmlib   -> /opt/java6/jre/lib/sparc/server

	 .profile:

Add "opt/java6/jrelib:/opt/java6/jvmlib" to the LD_LIBRARY_PATH

Solaris AMD64

	 /opt/java6/jrelib   -> /opt/java6/jre/lib/amd64

	 /opt/java6/jvmlib   -> /opt/java6/jre/lib/amd64/server

	 .profile:

Add "opt/java6/jrelib:/opt/java6/jvmlib" to the LD_LIBRARY_PATH

## EXAMPLES using JVM WITHOUT symbolic links as above:

Linux: looking for 'libjvm.so'

<pre>
    Add 2 directories to LD_LIBRARY_PATH.
    /opt/java6/jre/lib/amd64/server:/opt/java6/jre/lib/amd64</pre>

Solaris: looking for 'libjvm.so'

<pre>
    Add 2 directories to LD_LIBRARY_PATH.
    /opt/java6/jre/lib/sparc/server:/opt/java6/jre/lib/sparc</pre>

HP-UX 11: looking for 'libjvm.sl'

<pre>
    Add 2 directories to SHLIB_PATH.
   /opt/java6/jre/lib/IA64W/server:/opt/java6/jre/lib/IA64W</pre>

## OPTIONS

**JBCJVMLIB**

If the search for the library appears incorrect for your platform, then
you can override it by setting the **JBCJVMLIB** environment variable.

e.g.  `export JBCJVMLIB=jvm.shared_lib`

and then CALLJ will try to locate the library 'jvm.shared_lib' at runtime.

**JBCJVMPOLICYFILE**

You can specify a policy file for the JMV. The policy for a Java
application environment (specifying which permissions are available for
code from various sources) is represented by a Policy object. More
specifically, it is represented by a Policy subclass providing an
implementation of the abstract methods in the Policy class (which is in
the java.security package). You can override it by setting the
JBCJVMPOLICYFILE environment variable.

The source location for the default policy information is:

**WINDOWS**

<pre>
    %TAFC_HOME%\config\policy.all</pre>

**UNIX**

<pre>
    $TAFC_HOME/config/policy.all</pre>

e.g.  "export JBCJVMPOLICYFILE=/usr/jbase/mypolicy.all"

**JBCJVMENCODING**

Internally, the Java virtual machine always operates with data in
Unicode. However, as data transfers to or from the Java virtual
machine, the Java virtual machine converts the data to other encodings.
If the you want to change the default encoding of the JVM on your
platform, then you can override it by setting the JBCJVMENCODING
environment variable.

e.g.  "export JBCJVMENCODING=Cp1257"

**JBCJVMNOOPTS**

Internally, CALLJ is optimized to start the JVM with options (see the
table below). If you do not want to pass these options for the JVM,
then you can override it by setting the **JBCJVMNOOPTS** environment
variable. In this case no more options will be passed to the JVM.

**JBCIBMJDK**

On Linux we assumed that the Sun Java JDK would be used and the JVM
options reflect this. But as they are not compatible with the IBM JDK
you can set the JBCIBMJDK option to allow the running of the IBM JDK
for Linux.

## DEFAULT OPTIONS###

|Platform       |   Parameter                         |
|---------------|-------------------------------------|
|Win32:         |   -Xrs                              |
|Solaris:       |   -XX:+AllowUserSignalHandlers      |
|Linux:         |   -Xrs -XX:+AllowUserSignalHandlers |
|AIX 64 bits:   |   -Xrs -d64                         |
|HPUX 64 bits:  |   -Xrs -XX:+AllowUserSignalHandlers |

**JBCJVMOPT[1..5]**

If the you want to pass some options for the JVM, then set the
JBCJVMOPT[1..5] environment variable

e.g.  "export JBCJVMOPT1=-Xrs"

**JBCJVMOPTS**

Allows many options to be set within one variable.
e.g. export JBCJVMOPTS="-Xrs -Xms256M -Xmx512M"

## KNOWN LIMITATIONS

**HP-UX**

There is a problem with HP-UX due to its dynamic loader. See man
dlopen(3C) for detail of the TLS limitation.

This means that the JVM library must be linked against the calling
program, there are no known problems caused by this.

'ldd progname' lists current external library references and we
need to add libjvm.

The symptom looks like this:

<pre>
    JVM: dl_error [Can't dlopen a library containing Thread Local Storage: libjvm.sl]</pre>

If the program is built with the required link as below then it works.

<pre>
    jbc -Jo callj.b -ljvm -L/opt/java6/jre/lib/IA64W/server</pre>

If the CALLJ statement is inside a subroutine, then the program that
calls the subroutine must be built as above.
