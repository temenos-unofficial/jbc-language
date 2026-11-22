# DELETEU

Use the DELETEU statement to delete a record without releasing the
update record lock set by a previous [READU](https://jbc-lang.org/pages/readu.md) statement

See also: [READ](https://jbc-lang.org/pages/read.md) statements.

Use the OPEN statement to open a file. If specifying a file variable in
the OPEN statement, use it in the DELETEU statement. You must place a
comma between the file variable and the record ID expression. If
specifying no file variable in the DELETEU statement, the statement
applies to the default file.

See also: [OPEN](https://jbc-lang.org/pages/open.md) statement for a description of the default file.
