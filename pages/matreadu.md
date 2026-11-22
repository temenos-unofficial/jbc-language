# MATREADU

MATREADU statement allows a record stored in a jBASE file to be read
and mapped directly into a dimensioned array. The record will also be
locked for update by the program.

## COMMAND SYNTAX

    MATREADU array FROM {variable1,} expression { SETTING setvar } \
            { ON ERROR statements } \
            { LOCKED statements } { THEN | ELSE statements }

## SYNTAX ELEMENTS

**array** should be a previously dimensioned array, which will be used
to store the record to be read. If specified, **variable1** should be a
jBC variable that has previously been opened to a file using the
[OPEN](https://jbc-lang.org/pages/open.md) statement. If **variable1** is not specified then the
default file is assumed. The expression should evaluate to a valid
record key for the file.

If found, the record could be read from the file then it is mapped into
array and executes the THEN statements (if any). If the record cannot be
read from the file for some reason then array is unchanged and executes
the ELSE statements (if any).

If the record could not be read because another process already had a
lock on the record then one of two actions is taken. If the LOCKED clause
was specified in the statement then the statements dependent on it are
executed. If no LOCKED clause was specified then the statement blocks
(hangs) until the other process releases the lock.

If the SETTING clause is specified, setvar will be set to the number of
fields in the record on a successful read. If the read fails, setvar
will be set to one of the following values:

## INCREMENTAL FILE ERRORS

|Code   |    Description                        |
|-------|---------------------------------------|
|128    |    No such file or directory          |
|4096   |    Network error                      |
|24576  |    Permission denied                  |
|32768  |    Physical I/O error or unknown error|

If ON ERROR is specified, the statements following the ON ERROR clause
will be executed for any of the above Incremental File Errors except
error 128.

## NOTES

The record is mapped into the array using a predefined algorithm. The
record is expected to consist of a number of Field separated records,
which are then assigned one at a time to each successive element of the
matrix. See the NOTES on matrix organization earlier in this
section for details of the layout of multi dimensional arrays.

If there were more fields in the record than elements in the array,
then the final element of the array will be assigned all remaining
fields. If there were fewer fields in the record than elements in
the array then remaining array elements will be assigned a null
value.

If multi-values are read into an array element then they will be
referenced individually as:

    Array(n)<1,m>

not

    Array(n)<m>

## EXAMPLES

    MATREADU Xref FROM CFile, "XREF" ELSE MAT Xref = ''
    MATREADU Ind FROM IFile, "INDEX" LOCKED
       GOSUB InformUserLock ;* Say it is locked
    END THEN
       GOSUB InformUserOk ;* Say we got it
    END ELSE
       MAT Ind = 0 ;* It was not there
    END

    MATREADU record FROM filevar, id SETTING val ON ERROR
       PRINT "Error number " :val: " occurred which prevented record from being read"
       STOP
    END LOCKED
       PRINT "Record is locked"
    END THEN
       PRINT 'Record read successfully'
    END ELSE
       PRINT 'Record not on file'
    END
    PRINT "Number of attributes in record = " : val
