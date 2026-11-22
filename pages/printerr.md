# PRINTERR

PRINTERR statement is used to print standard jBASE error messages.

## COMMAND SYNTAX

    PRINTERR expression

## SYNTAX ELEMENTS

Field 1 of the **expression** should evaluate to the numeric or string
name of a valid error message in the jBASE error message file. If the
error message requires parameters then these can be passed to the message
as subsequent fields of the expression.

## INTERNATIONAL MODE

When the PRINTERR statement is used in International Mode, the error
message file to be used, i.e. the default "jBASICmessages" or other as
configured via the error message environment variable, will be suffixed
with the current locale. For example, if the currently configured
locale is "fr_FR" then the statement will attempt to find the specified
error message record id in the "jBASICmessages_fr_FR" error message
file. If the file cannot be found then the country code will be discarded
and just the language code used. i.e. the file "jBASICmessages_fr" will
be used. If this file is also not found then the error message file
"jBASICmessages" will be used.

## NOTES

The PRINTERR statement is most useful for user-defined messages that
have been added to the standard set.

You should be very careful when typing this statement it is very
similar to the PRINTER statement. Although this is not ideal, the
PRINTERR statement must be supported for compatibility with older
systems.

## EXAMPLE

       PRINTERR 201 : CHAR(254) : "CUSTOMERS"

Output:

<pre>
     &lowast;&lowast; Error [ 201 ] &lowast;&lowast;
    Unable to open file CUSTOMERS</pre>
