# UD type

Folders are also treated like data files (type UD); flat files in them -
like records. This allows, for example, use JED to edit source code.
Data can be copied transparently between hashed
files and folders. Some examples:

Create the folder:

<pre>
    CREATE-FILE DATA TEST.BP TYPE=UD
    &nbsp;
    [ 417 ] File TEST.BP created , type = UD</pre>

Create a program:

<pre>
    JED TEST.BP PROG1
    &nbsp;
    0001 CRT 2*2</pre>

Save file. Compile and run it:

<pre>
    BASIC TEST.BP PROG1
    &nbsp;
    PROG1
    BASIC_3.c
    Source file PROG1 compiled successfully</pre>

<pre>
    CATALOG TEST.BP PROG1
    &nbsp;
    PROG1
    Object PROG1 cataloged successfully</pre>

<pre>
    PROG1
    &nbsp;
    4</pre>

Copy data:

<pre>
    COPY FROM F.SAMPLE TO TEST.BP REC1
    &nbsp;
    1 records copied</pre>

Edit file REC1 in TEST.BP folder with any text editor so it now looks like:

<pre>
    Field one - updated
    Field two
    Field three</pre>

Copy it back to hashed file:

<pre>
    COPY FROM TEST.BP TO F.SAMPLE REC1 OVERWRITING
    &nbsp;
    1 records copied</pre>

See the result:

<pre>
    LIST F.SAMPLE
    &nbsp;
    F.SAMPLE......     ID..................   FIELD 1 HEADER
    &nbsp;
    REC1               REC1                   Field one - up
                                              dated</pre>
