# Create/delete hashed file

Create both data and dictionary:

<pre>
    CREATE-FILE F.SAMPLE 101 1
    &nbsp;
    [ 417 ] File F.SAMPLE]D created , type = J4
    [ 417 ] File F.SAMPLE created , type = J4</pre>

If the file already exists, the error message appears:

<pre>
    [ 413 ] File name DICT F.SAMPLE already exists</pre>

Delete hashed file (both data and dictionary):

<pre>
    DELETE-FILE F.SAMPLE</pre>

Create hashed file (data only):

<pre>
    CREATE-FILE DATA F.SAMPLE 101 1
    &nbsp;
    [ 417 ] File F.SAMPLE created , type = J4</pre>

Create hashed file (dictionary only):

<pre>
    CREATE-FILE DICT F.SAMPLE 101 1
    &nbsp;
    [ 417 ] File F.SAMPLE]D created , type = J4</pre>
