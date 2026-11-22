# Create and list the data

Put some data to file:

<pre>
    JED F.SAMPLE REC1
    &nbsp;
    0001 Field one
    0002 Field two
    0003 Field three</pre>

Press Esc; then type FI to save the record.

List file contents:

<pre>
    LIST F.SAMPLE
    &nbsp;
    F.SAMPLE......
    &nbsp;
    REC1
    &nbsp;
    1 Records Listed</pre>

No dictionary; we see only @ID. Raw output:

<pre>
    CT F.SAMPLE
    &nbsp;
    REC1
    001 Field one
    002 Field two
    003 Field three</pre>

As an alternative, we can use standard correlatives:

<pre>
    LIST F.SAMPLE &lowast;A1 &lowast;A2 &lowast;A3
    &nbsp;
    F.SAMPLE......   &lowast;A1...........   &lowast;A2...........   &lowast;A3...........
    &nbsp;
    REC1             Field one        Field two         Field three</pre>
