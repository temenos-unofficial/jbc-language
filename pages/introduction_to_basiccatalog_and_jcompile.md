# Introduction to BASIC...CATALOG and jcompile

<pre>
    BASIC MY.BP TEST.SUB
    &nbsp;
    TEST.SUB
    BASIC_1.c
    Source file TEST.SUB compiled successfully</pre>

<pre>
    CATALOG MY.BP TEST.SUB
    &nbsp;
    TEST.SUB
    Object TEST.SUB cataloged successfully
    Library $HOME\lib\lib0.dll rebuild okay</pre>

<pre>
    jcompile test.b
    &nbsp;
    Warning: Variable DIV.AMT2 is never assigned!
    test.c</pre>

Compilation results in appearance of an object and executable files
(sample for Windows):

<pre>
    test.obj
    test.dll
    test.exe</pre>

**See program information**:

<pre>
    jshow -c test
    &nbsp;
    Executable:          C:\r11\BATfiles\test.dll
                         jBC main() version 11.0 Thu Dec 06 23:35:34 2012
                         jBC main() source file unknown
    Executable (DUP!!):  C:\r11\BATfiles\test.exe
                         jBC main() version 11.0 Thu Dec 06 23:35:34 2012
                         jBC main() source file unknown</pre>

If the code is recompiled very often then it might happen that the older version
of executable code
still resides in shared memory and the result of changes wouldn't be seen immediately.
In this case "-E" option of jcompile can be used to build executable only
and not the shared library, e.g.:

<pre>
    jcompile -E test.b</pre>

And then test.dll isn't created. The final compilation is of course to be done
without "-E" option. Also - without shared library CHAIN statement might work
not as expected and persistence of COMMON areas won't be supported.

**See commands** used by compiler:

<pre>
    jcompile -v test.b
    &nbsp;
    cl /nologo /DWIN32 /MD /W2 /GR /EHa -c -IC:\TAFC\include -DJBC_OPTLEVEL2 test.c
    ...
    cl /nologo /DWIN32 /MD /W3 /GR /EHa /GF /Zi /F5000000 -D_LARGEFILE_SOURCE ...</pre>

**Conditional compilation**:

       V.VAR = 1
       CRT 'Version ':
    #ifdef VER1
       CRT V.VAR:
    #else
       CRT V.VAR + 1:
    #endif
       CRT ' finished'

<pre>
    jcompile -DVER1 test.b
    test.c
    &nbsp;
    test
    Version 1 finished</pre>

<pre>
    jcompile test.b
    test.c
    &nbsp;
    test
    Version 2 finished</pre>

**To look at C code** rather than to create executables "-S" option can be used
(files test.c and test.j will be created for test.b source).

Full information about jcompile options - "jcompile -H".
