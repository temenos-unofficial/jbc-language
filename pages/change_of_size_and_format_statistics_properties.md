# Change of size and format, statistics, properties

See file statistics:

<pre>
    jstat -v F.SAMPLE
    &nbsp;
    File C:\r11\bnk\bnk.run\F.SAMPLE
    Type=J4 , Hash method = 5
    Created at Tue Nov 20 19:38:25 2012
    Groups = 101 , Frame size = 4096 bytes , Secondary Record Size = 8192 bytes
    Restore re-size parameters : (none)
    File size = 417792 bytes , Inode = 29838 , Device = Id 24915
    Last Accessed Tue Nov 20 19:50:30 2012 , Last Modified Tue Nov 20 19:50:30 2012
    Backup = YES , Log = YES , Rollback = YES , Network = NO
    Record Count = 1 , Record Bytes = 45
    Bytes/Record = 45 , Bytes/Group = 0
    Primary file space:   Total Frames = 101 , Total Bytes = 45
    Secondary file space: Total Frames = 0 , Total Bytes = 0</pre>

## NOTE

101 - number of groups - was defined when file was created.

Add more records:

<pre>
    COPY FROM F.SAMPLE REC1,REC2
    &nbsp;
    1 records copied</pre>

Try to resize the file:

<pre>
    jrf -V F.SAMPLE
    &nbsp;
    ...
    Downsizing skipped from modulo 101 to 3.</pre>

Resize it anyway:

<pre>
    jrf -VD F.SAMPLE
    &nbsp;
    ...
    Downsizing from modulo 101 to 3</pre>

Change file type to JR:

<pre>
    jrf -H6 F.SAMPLE</pre>

See statistics now:

<pre>
    jstat -v F.SAMPLE
    &nbsp;
    File Type       = JR,        Hash method = 5, Created = Tue Nov 20 19:56:00 2012
    Frame size      = 4096,        OOG Threshold   = 2048
    File size       = 8192, Freespace       = 0 frames
    Internal Modulo = 3/7/11,      External Modulo = 13
    Inode no.       = 29838,       Device no.      = 24915
    Accessed        = Tue Nov 20 19:56:13 2012, Modified  = Tue Nov 20 19:56:13 2012
    Backup  = YES, Log      = YES, Rollback        = YES,  Secure updates  = NO
    Deallocate pointers : NO       Deallocate frames NO
    Revision level  = 2
    Record Bytes    = 82,   Record Count    = 2
    Bytes/Record    = 41,   Bytes/Group     = 82
    Data Frames     = 1,    Ptr Frames      = 0
    OOG Bytes       = 0,    OOG Frames      = 0
    Sum Squares     = 3362, Std Dev Mean    = 41</pre>

Turn on secure updates:

<pre>
    jchmod +S F.SAMPLE</pre>

Check the result:

<pre>
    jstat -v F.SAMPLE
    &nbsp;
    ...
    Backup  = YES, Log      = YES,  Rollback        = YES,  Secure updates  = YES
    ...</pre>

Delete a record:

<pre>
    DELETE F.SAMPLE REC2
    &nbsp;
    1 record(s) deleted.</pre>

Add data sections:

<pre>
    CREATE-FILE F.SAMPLE,TWO TYPE=JR
    &nbsp;
    [ 417 ] File F.SAMPLE]MTWO created , type = JR</pre>

<pre>
    CREATE-FILE F.SAMPLE,THREE TYPE=JR
    &nbsp;
    [ 417 ] File F.SAMPLE]MTHREE created , type = JR</pre>

Create a record in a section:

<pre>
    JED F.SAMPLE,TWO REC5
    &nbsp;
    0001 Section 2/1
    0002 Section 2/2
    0003 Section 2/3</pre>

See that all sections use the same dictionary:

<pre>
    LIST F.SAMPLE,TWO
    &nbsp;
    F.SAMPLE,TWO..    ID..................    FIELD 1 HEADER
    &nbsp;
    REC5              REC5                    Section 2/1</pre>

<pre>
    LIST F.SAMPLE,THREE
    &nbsp;
    F.SAMPLE,THREE    ID..................    FIELD 1 HEADER
    &nbsp;
     No Records Listed</pre>

## NOTE

File F.SAMPLE still reports 1 record in it; here's the difference
between having several data sections and a distributed file.
