# FOOTING

The FOOTING statement halts all subsequent output to the terminal at
the end of each output page. The statement allows the evaluation and
display of an expression at the foot of each page. Output, which is
current, and being sent to the terminal, the output is paused until
the entry of a carriage return at the terminal (unless the N option
is specified either in the current HEADING or in this FOOTING).

## COMMAND SYNTAX

    FOOTING expression

## SYNTAX ELEMENTS

The expression should evaluate to a string, which is printed at the
bottom of every page of output. The string could contain a number of
interpreted special characters, replaced in the string before printing.

The following characters have special meaning within the string:

| Value     |    Description                                         |
|-----------|--------------------------------------------------------|
|"C{n}"     |  Center the line. If n is specified the output line is |
|           |  assumed to be n characters long.                      |
|"D" or \\  |  Replace with the current date.                        |
|"L" or ]   |  Replace with the newline sequence.                    |
|"N"        |  Terminal output does not pause at the end of each     |
|           |  page.                                                 |
|"P" or ^   |  Replace with the current page number.                 |
|"PP" or ^^ |  Replace with the current page number in a field of 4  |
|           |  characters. The field is right justified.             |
|"T" or \   |  Replace with the current time and date.               |
|"          |  Replace with a single " character.                    |

## NOTES

If the output is to the printer a PRINTER ON statement is in force;
output sent to the terminal with the CRT statement is not paged; if
output is to the terminal then all output is paged.

## EXAMPLE

    FOOTING 'Programming staff by weight Page "P"'
