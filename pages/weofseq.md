# WEOFSEQ

WEOFSEQ truncates a file opened for sequential access.

## COMMAND SYNTAX

    WEOFSEQ FileVar { THEN | ELSE Statements }

## SYNTAX ELEMENTS

**FileVar** specifies the file descriptor of the file opened for
sequential access.

**Statements** are conditional jBC statements.

## NOTES

WEOFSEQ forces truncation of the file at the current file pointer;
nothing is actually written to the sequential file.

## EXAMPLE

       out_dir = '.'
       out_file = 'report.txt'
    &nbsp;
       OPENSEQ out_dir, out_file TO f_out THEN
          CRT 'TARGET FILE EXISTS. OVERWRITE[Y/N]':
          CLEARINPUT          ;* don't take anything in advance
          INPUT reply
          IF UPCASE(reply) NE 'Y' THEN         ;* y or Y
    * exit - user refused to overwrite the file
             STOP             ;* or RETURN
          END
          WEOFSEQ f_out  ;* truncate the file
       END
    &nbsp;
    * We don't need to explicitly create a file; as soon as the first
    * WRITESEQ will be issued - file will be created, otherwise it won't be -
    * "openseq_creates" isn't set to "true" for Prime emulation.
    &nbsp;
    * Processing loop starts
       line_no = 0
       LOOP
          line_no ++
    &nbsp;
    * Provide a way to exit a loop
          IF line_no GT 7 THEN BREAK
    &nbsp;
    * Get an output string into variable and...
          line = 'Line ' : line_no
    * ...either skip it...
          IF line_no EQ 3 THEN CONTINUE
    * ...or write it
          WRITESEQ line TO f_out ELSE
    * Write error - notify user and quit the program
             CRT 'Write error'
             STOP             ;* or RETURN
          END
       REPEAT
    &nbsp;
    * truncate the file at certain position
       SEEK f_out, -5, 2 ELSE CRT 'Seek error'  ;  STOP
       WEOFSEQ f_out
       CLOSESEQ f_out

Contents of file report.txt:

<pre>
    Line 1
    Line 2
    Line 4
    Line 5
    Line 6
    Li</pre>
