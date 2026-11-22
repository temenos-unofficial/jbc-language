# Customize work folders and files location

Main dictionary location (usually points to VOC file):

<pre>
    JEDIFILENAME_MD</pre>

Path to SYSTEM file (normally located in [path to installed TAFC]/src):

<pre>
    JEDIFILENAME_SYSTEM</pre>

Default path to jBASE data files:

<pre>
    JEDIFILEPATH</pre>

Location where programs will be put after compilation:

<pre>
    JBCDEV_BIN</pre>

The folder where shared libraries for compiled subroutines are located:

<pre>
    JBCDEV_LIB</pre>

Path to jBASE spooler folder:

<pre>
    JBCSPOOLERDIR</pre>

The folder where saved lists are placed:

<pre>
    JBCLISTFILE</pre>

Where to look for libraries containing compiled subroutines:

<pre>
    JBCOBJECTLIST</pre>

Could be several entries, e.g.:

Windows:

<pre>
    set JBCOBJECTLIST=%HOME%\lib;%HOME%\t24lib</pre>

Unix/Linux:

<pre>
    export JBCOBJECTLIST=$HOME/lib:$HOME/t24lib</pre>

If a subroutine presents in more than one location (which can be caused by
changing JBCDEV_LIB environment variable or accidental duplication of a
subroutine name) then the earlier location has the preference. See jshow output:

<pre>
    jshow -c ACCOUNT
    Subroutine:          C:\r11\bnk\bnk.run\lib\lib2.dll
                         jBC ACCOUNT version 11.0 Thu Sep 06 22:09:46 2012
                         jBC ACCOUNT source file ETC.BP
    Subroutine (DUP!!):  C:\r11\bnk\bnk.run\t24lib\acm_accountopening\lib0.dll
                         jBC ACCOUNT version 11.0 Fri Apr 29 14:43:35 2011
                         jBC ACCOUNT source file source/R11.000/win32_TAFCR11GA</pre>

In situation like that DECATALOG is to be used:

<pre>
    DECATALOG ETC.BP ACCOUNT
    Object ACCOUNT decataloged successfully
    Library C:\r11\bnk\bnk.run\lib\lib2.dll rebuild okay</pre>

<pre>
    jshow -c ACCOUNT
    Subroutine:          C:\r11\bnk\bnk.run\t24lib\acm_accountopening\lib0.dll
                         jBC ACCOUNT version 11.0 Fri Apr 29 14:43:35 2011
                         jBC ACCOUNT source file source/R11.000/win32_TAFCR11GA</pre>
