# STATUS

STATUS function after an OPENPATH statement to find the cause of a file
open failure (that is, for an  tatement in which the ELSE clause is
used).
The following values can be returned if the  statement is unsuccessful:

For File access commands

[READ](https://jbc-lang.org/pages/read.md), [WRITE](https://jbc-lang.org/pages/write.md), [OPEN](https://jbc-lang.org/pages/open.md)

*Previous Operation*

Value = 0 if successful

Value = Operating System error code if previous command failed

13 - permission denied on UNIX systems

*OCONV Conversions*

0 = successful

1 = invalid conversion requested

3 = conversion of possible invalid date

## COMMAND SYNTAX

    STATUS()

## DESCRIPTION

Arguments are required for the STATUS function.

Values of STATUS after [CLOSE](https://jbc-lang.org/pages/close.md), [DELETE](https://jbc-lang.org/pages/delete.md),
[MATREAD](https://jbc-lang.org/pages/matread.md), [MATWRITE](https://jbc-lang.org/pages/matwrite.md), [OPEN](https://jbc-lang.org/pages/open.md),
[READ](https://jbc-lang.org/pages/read.md) and [WRITE](https://jbc-lang.org/pages/write.md)

*After a [DELETE](https://jbc-lang.org/pages/delete.md) statement:* After a DELETE statement
with an ON ERROR clause, the value returned is the error number.

Returns 0 if successful else returns ERROR number

*After an [OPEN](https://jbc-lang.org/pages/open.md), [OPENPATH](https://jbc-lang.org/pages/openpath.md), or [OPENSEQ](https://jbc-lang.org/pages/openseq.md) statement:*
The file type is returned if the file is opened
successfully. If the file is not opened successfully, the following
values may return:

*After a [READ](https://jbc-lang.org/pages/read.md) statement:* If the file is a distributed file,
the STATUS function returns the following:

*After a [READL](https://jbc-lang.org/pages/readl.md), [READU](https://jbc-lang.org/pages/readu.md), [READVL](https://jbc-lang.org/pages/readvl.md), or [READVU](https://jbc-lang.org/pages/readvu.md) statement:*
If the statement includes the LOCKED
clause, the returned value is the terminal number, as returned by
the
WHO command, of the user who set the lock.

*After a [READSEQ](https://jbc-lang.org/pages/readseq.md) statement:*

*After a [READT](https://jbc-lang.org/pages/readt.md), [REWIND](https://jbc-lang.org/pages/rewind.md), [WEOF](https://jbc-lang.org/pages/weof.md), or [WRITET](https://jbc-lang.org/pages/writet.md) statement:*
The returned value is
hardware-dependent (that is, it varies according to the
characteristics of the specific tape drive unit).
Consult the documentation that accompanied your tape drive
unit for information about interpreting the values returned
by the STATUS function.

## EXAMPLE

       DELETE not_valid_filevar, 'REC5' SETTING ret_code ON ERROR
          CRT 'REC5 - DELETE ERROR'
       END
       CRT STATUS()           ;*  -1
       CRT ret_code           ;*  32768

***TAFJ note: STATUS() function works incorrectly processing results of erroneous conversions. Example:***

       CRT OCONV('qwerty', 'qwerty') : '_' : STATUS()   ;* expected: _1, output: _2
       CRT ICONV('20483344', 'D') : '_' : STATUS()      ;* expected: _3, output: _1
