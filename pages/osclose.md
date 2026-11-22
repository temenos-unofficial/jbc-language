# OSCLOSE

OSCLOSE command closes a sequential file that you have opened with the
OSOPEN or OPENSEQ command.

## COMMAND SYNTAX

    OSCLOSE file.var [ ON ERROR statements ]

## SYNTAX ELEMENTS

**file.var** specifies the file to close.

**ON ERROR statements** specifies statements executed when the OSCLOSE
statement fails with fatal error, I/O error, or JBASE cannot find the
file.

If you do not specify the ON ERROR clause and a fatal error occurs, the
program will enter the debugger.

*STATUS Function Return Values*

After you execute OSCLOSE, the STATUS function returns either 0 or a
failure code.

| Code | Description                   |
|------|-------------------------------|
|0     | Closes the file successfully. |
|1     | Fails to write the file.      |

## EXAMPLE

In the following example, the program statement closes the file opened
to MYPIPE file variable.

    OSCLOSE MYPIPE
