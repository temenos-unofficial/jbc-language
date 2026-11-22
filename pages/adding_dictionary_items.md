# Adding dictionary items

Add a dictionary item to assign the name to a field:

<pre>
    JED DICT F.SAMPLE FLD1
    &nbsp;
    0001 D
    0002 1
    0003
    0004 FIELD 1 HEADER
    0005 10L
    0006 S
    0007</pre>

Use field name in a query:

<pre>
    LIST F.SAMPLE FLD1
    &nbsp;
    F.SAMPLE......   FIELD 1 HEADER
    &nbsp;
    REC1             Field one
    &nbsp;
    1 Records Listed</pre>

<pre>
    LIST F.SAMPLE WITH FLD1 EQ ''
    &nbsp;
     No Records Listed</pre>

In default view we still dont have it:

<pre>
    LIST F.SAMPLE
    &nbsp;
    F.SAMPLE......
    &nbsp;
    REC1</pre>

Set the field to be seen by default:

<pre>
    JED DICT F.SAMPLE @
    &nbsp;
    0001 PH
    0002 @ID FLD1</pre>

See the result:

<pre>
    LIST F.SAMPLE
    &nbsp;
    F.SAMPLE......   ID..................   FIELD 1 HEADER
    &nbsp;
    REC1             REC1                   Field one</pre>
