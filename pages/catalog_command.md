# CATALOG Command

**Cataloging and Running your Programs**

Use the CATALOG command to create UNIX executables and shared libraries
from the application source code. Once you have cataloged your programs,
you can run them like any other command on the system.

The RUN command which is sometimes used to execute compiled jBC
programs without cataloging them can still be used but is really only
maintained for compatibility. Whenever possible, you should catalog your
programs rather than RUN them.

The CATALOG command should be executed from the application directory
rather than using link names and the application id should be used.
The reasons for executing the CATALOG command from the application
directory and application id are that the .profile script will have set
up the required environment variables correctly and that the correct
file permission will be used when creating and deleting UNIX
executables and directories.

The format of the CATALOG command is as follows.

<pre>
    CATALOG SourceFilename Itemlist</pre>

When first invoked the CATALOG command will create a $HOME/bin directory
into which the UNIX executables will be placed. A $HOME/lib directory
will also be created into which any subroutines will be placed. The lib
directory contains a jLibDefinition file, which describes how to build
the subroutines into shared libraries. The entries in the
jLibDefinition file are described below:

|Entry         |  Description                                    |
|--------------|-------------------------------------------------|
| libname      |  naming convention for shared object files.     |
| exportname   |  export list of shared objects. Used as cross   |
|              |  reference to find subroutine functions.        |
| maxsize      |  maximum size of a shared object library before |
|              |  creating another.                              |

When the maximum size of a shared library object is reached then a new
shared library object will be created by the CATALOG command. The new
shared library objects are named according to the definition of libname
and are numbered sequentially. For example:

libname=lib%a%n.so

where

%a = account or directory name

%n = number in sequence.

If subroutines were cataloged in the user account name, fred then the
shared object libraries produced would be named, libfred0.so
libfred1.so libfred2.so and so on.

Note: To guard against libraries being cataloged incorrectly, perhaps
under the wrong user account name, the definition of libname should
be changed to libfred%n.so. This will ensure that any shared objects
are created using the proper user account name.

The shared library objects,.so files, contain the UNIX executables for
subroutine source code. The shared library objects are linked at
runtime by the TAFC call function, which utilises the dynamic linker
programming interface. The dynamic linker will link shared libraries
at the start of program execution time, or when requested by the TAFC
call function. For example, each executable created using the TAFC
compiler will be linked with the TAFC jEDI library functions, libjedi.so,
at compilation time. This shared library enables database record
retrieval and update and will be loaded into memory by the dynamic
linker when an application executable starts execution. However the
shared library containing any subroutines required by the executing
program will only be loaded into memory when initially requested by the
subroutine call. Only one copy of any shared library is required in
memory at any time, thus reducing program memory requirements.

The $HOME/lib directory also contains a directory where all the subroutine
objects, .o files, are held. These are required for making the shared
library, .so files.

The $HOME/lib directory also contains an export list, .el file, built by
the CATALOG command, which is used as a cross reference when dynamically
linking shared objects at run time.

The main application program executables are placed into the $HOME/bin
directory.

To enable the application executables to be found the $HOME/bin path
should be added to the PATH environment variable.

To enable the executing application to call the correct application
subroutines the JBCOBJECTLIST or LD_LIBRARY_PATH environment variable
should be assigned to the application shared library path, $HOME/lib.
If the main application program or any subroutine programs make calls
to subroutines in other directories then the path of the shared library
directories should also be added to the JBCOBJECTLIST or LD_LIBRARY_PATH
environment variable.

It is recommended that executables or subroutines of the same name are
not available from different directories. This can make application
execution very confusing and is reliant on assigning the lib or bin
directories to the environment variable in the correct sequence. The
assignment of the environment variables should be included and exported
in the .profile script file.

Executables and shared library objects can be removed from the bin and l
ib directories by using the DECATALOG command.
