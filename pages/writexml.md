# WRITEXML

Use WRITEXML to write an XML record to a hashed file.

## COMMAND SYNTAX

    WRITEXML rec ON file,id ELSE statements | ON ERROR statements

Writes a dynamic array in xml format using a style sheet from the
DICT; transforms the XML into a dynamic array before being written to
the file.

The transform takes place using the style sheet in DICT (record @WRITEXML).

## EXAMPLE

    WRITEXML rec ON file,id ON ERROR CRT "Broken! " : rec
