# READXML

READXML rec FROM file, id ELSE STOP 202,id

Reads a record from a file using the style sheet held in
DICT->@READXML to transform the data into xml format

## EXAMPLE

       READ rec FROM file,id THEN
          CRT rec
       END
       READXML xml FROM file,id THEN
          CRT xml
       END

Screen output:

<pre>
    CLIVE^PIPENSLIPPERS^999 LETSBE AVENUE
    ...
    &lt;?xml version="1.0" encoding="UTF-8"?&gt;
    &lt;mycustomer&gt;
    &lt;firstname&gt;CLIVE&lt;/firstname&gt;
    &lt;lastname&gt;PIPENSLIPPERS&lt;/lastname&gt;
    &lt;address&gt;999 LETSBE AVENUE&lt;/address&gt;</pre>
