# GETUSERGROUP

If the statement succeeds in retrieving the list, then the statements
the user ID specified by @uid. For Windows NT or Windows 2000, it
returns zero.

## COMMAND SYNTAX

    GETUSERGROUP(uid)

## EXAMPLES

In the following example, the program statement assigns the user group
to variable X:

    X = GETUSERGROUP(@UID)

In the next example, the program statement assigns the user group for
1023 to variable X:

    X = GETUSERGROUP(1023)
