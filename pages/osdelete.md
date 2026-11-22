# OSDELETE

OSDELETE command deletes a NT or UNIX file.

## COMMAND SYNTAX

    OSDELETE filename [ ON ERROR statements ]

## SYNTAX ELEMENTS

**filename** specifies the file to be deleted. Filename must include the
file path. If you do not specify a path, jBASE searches the current
directory.

**ON ERROR statements** specifies the statements to execute if the
OSDELETE statement fails with fatal error, I/O error, or jBASE cannot
find the file.

If you do not specify the ON ERROR clause and a fatal error occurs,
the program will terminate.

*STATUS Function Return Values*

After you execute OSDELETE, the STATUS function returns either 0 or
a failure code.

| Code | Description                     |
|------|---------------------------------|
|0     |  Deletes the file successfully. |
|1     |  Fails to delete the file.      |

## EXAMPLES

In the following example, the program statement deletes the file
'MYPIPE' in the current directory:

    OSDELETE "MYPIPE"
