# GETCWD

The GETCWD function allows a jBC program to determine the current working
directory of the program, which is normally be the directory in which
execution of the program occurred but possibly changed using the CHDIR()
function.

## COMMAND SYNTAX

    GETCWD(Var)

## SYNTAX ELEMENTS

When executed the Var will be set to the name of the current working
directory; the function itself returns a Boolean TRUE or FALSE value to
indicate whether the command was successful or not.

## NOTES

Refer to your UNIX or Windows documentation for more information on the
concept of the current working directory.

## EXAMPLES

    IF GETCWD(Cwd) THEN
       CRT "Current Working Directory = " : Cwd
    END ELSE
       CRT "Could not determine CWD!"
    END
