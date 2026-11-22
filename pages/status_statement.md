# STATUS statement

STATUS statement is used to determine the status of an open
file. It returns the file status as a dynamic array and assigns
it to an array.

## COMMAND SYNTAX

    STATUS array FROM variable THEN statements ELSE statements | ELSE statements

## SYNTAX ELEMENTS

The STATUS statement returns the following values in the following
attributes:

*STATUS Statement Values*

|Attribute  | Description                                         |
|-----------|-----------------------------------------------------|
|1          | Current position in the file Offset in bytes from   |
|           | beginning of file                                   |
|2          | End of file reached 1 if EOF, 0 if not.             |
|3          | Error accessing file 1 if error, 0 if not.          |
|4          | Number of bytes available to read                   |
|5          | File mode Permissions (in octal) 6 File size in     |
|           | bytes.                                              |
|7          | Number of hard links 0 if no links. Where applicable|
|           | else 0                                              |
|8          | O/S User ID. ID based on the user name and domain of|
|           | the user a jBASE pseudo user.                       |
|9          | O/S Group ID.                                       |
|10         | I-node number; Unique ID of file on file system     |
|11         | Device on which i-node resides Number of device. The|
|           | value is an internally calculated value on Windows  |
|           | NT.                                                 |
|12         | Device for special character or block Number of     |
|           | device.                                             |
|13         | Time of last access in internal format              |
|14         | Date of last access in internal format.             |
|15         | Time of last modification in internal format        |
|16         | Date of last modification in internal format.       |
|17         | Time and date of last status change in internal     |
|           | format.                                             |
|18         | Date of last status change in internal format.      |
|19         | Number of bytes left in output queue (applicable to |
|           | terminals only)                                     |
|20         | {  }                                                |
|21         | jBASE File types j3, j4, jPLUS                      |
|22         | jBASE File types j3, j4, jPLUS                      |
|23         | jBASE File types j3, j4, jPLUS                      |
|24         | Part numbers of part files belonging to a           |
|           | distributed file multivalued list                   |

**variable** specifies an open file. If variable evaluates to the null
value, the STATUS statement fails and the program terminates with a
run-time error message.

If the STATUS array is assigned to an array, the THEN statements are
executed and the ELSE statements are ignored. If no THEN statements
are present, program execution continues with the next statement. If
the attempt to assign the array fails, the ELSE statements are
executed; any THEN statements are ignored.

## EXAMPLE

       IF NOT( GETENV('JEDIFILENAME_SYSTEM', FN.SYSTEM) ) THEN ABORT
       OPEN FN.SYSTEM TO F.SYSTEM ELSE NULL
       STATUS V.INFO.L FROM F.SYSTEM ELSE ABORT
       CRT V.INFO.L<5>       ;*  permissions in octal, e.g. 655
       CRT V.INFO.L<6>       ;*  file size in bytes
       CRT V.INFO.L<20>      ;*  full path to file
       CRT V.INFO.L<21>      ;*  file type, e.g. J4, JR, XMLDB2, SEQ
