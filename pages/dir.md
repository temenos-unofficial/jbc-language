# DIR

Use the DIR function to return information about a file.

## COMMAND SYNTAX

    DIR(filename)

The filename is a string argument representing the path and filename
of a file. This function returns a dynamic array with four attributes.

| Attribute |                 Description              |
|-----------|------------------------------------------|
|  1        |File size in bytes                        |
|  2        |last modified date (in internal format)   |
|  3        |last modified time (in internal format)   |
|  4        |D if the filename is a directory, blank if|
|           |the filename is a file.                   |

## EXAMPLE

       IF NOT( GETENV('TAFC_HOME', V.HOME) ) THEN
          CRT 'TAFC_HOME not defined'
          STOP
       END
       CRT OCONV( DIR(V.HOME), 'MCP' )                  ;* e.g. 0^16214^32712^D
       CRT OCONV( DIR(V.HOME : '/jbcmessages'), 'MCP' ) ;* e.g. 204800^15815^57980
