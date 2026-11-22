# Minimum set of variables necessary to start development

Windows:

<pre>
    set TAFC_HOME=[path to installed TAFC]
    set JBCGLOBALDIR=%TAFC_HOME%
    set PATH=%TAFC_HOME%\bin;[path to C Compiler]\bin;%PATH%
    set JBCEMULATE=[your emulation; for T24 should be prime]
    set INCLUDE=[path to C Compiler]\include;%INCLUDE%
    set LIB=[path to C Compiler]\lib;%LIB%
    set JBCBASETMP=tmp_workfile</pre>

Unix/Linux:

<pre>
    export TAFC_HOME=[path to installed TAFC]
    export JBCGLOBALDIR=$TAFC_HOME
    export PATH=$TAFC_HOME/bin:$PATH
    export JBCEMULATE=[your emulation; for T24 should be prime]
    TTYNO=`tty | cut  -f4 -d\/`
    export JBCBASETMP=$HOME/jBASEWORK/tmp_$TTYNO
    export LD_LIBRARY_PATH=$TAFC_HOME/lib:/usr/ccs/lib:/usr/lib:/lib
    (Linux)
    export LIBPATH=$TAFC_HOME/lib:/usr/ccs/lib:/usr/lib
    (AIX)
    export SHLIB_PATH=$TAFC_HOME/lib:${SHLIB_PATH:-/usr/lib:/lib}
    (HP-UX)</pre>
