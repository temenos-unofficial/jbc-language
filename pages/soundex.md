# SOUNDEX

SOUNDEX function allows phonetic conversions of strings.

## COMMAND SYNTAX

    SOUNDEX(expression)

## SYNTAX ELEMENTS

**expression** may evaluate to any data type but the function will
only give meaningful results for English words.

## NOTES

The phonetic equivalent of a string is calculated as the first
alphabetic character in the string followed by a 1 to 3-digit
representation of the rest of the word.
The digit string is calculated from the following table:

|Characters     | Value code |
|---------------|------------|
|B F P V        |       1    |
|C G J K Q S X Z|       2    |
|D T            |       3    |
|L              |       4    |
|M N            |       5    |
|R              |       6    |

All characters not contained in the above table are ignored. The
function is case insensitive and identical sequences of a character are
interpreted as a single instance of the character.

The idea is to provide a crude method of identifying words such as last
names even if they are not spelt correctly. The function is not
foolproof should not be the sole method of identifying a word.

## EXAMPLE

    INPUT Lastname
    Lastname = SOUNDEX(Lastname)
    *search the databases
