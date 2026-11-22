# CONVERT

The CONVERT function is the function form of the CONVERT statement. It
performs exactly the same function but may also operate on an expression
rather than being restricted to variables.

## COMMAND SYNTAX

    CONVERT(expression1, expression2, expression3)

## SYNTAX ELEMENTS

**expression1** is the string to which the conversion will apply.

**expression2** is the list of all characters to translate in
expression1.

**expression3** is the list of characters that will be converted to.

*NOTE:* For Prime, Universe and Unidata emulations:

**expression1** is the list of all characters to translate in
expression1.

**expression2** is the list of characters that will be converted to.

**expression3** is the string to which the conversion will apply.

See also: [CONVERT (STATEMENT)](https://jbc-lang.org/pages/convert_statement.md))

## EXAMPLE

    * compile this program under same emulation that you're testing
       IF NOT( GETENV('JBCEMULATE', jbc_emu) ) THEN
          CRT 'Emulation setting not found'
          STOP
       END
       *
       the_string = 'ABCCCDEFCDYZ'
       IF jbc_emu = 'prime' THEN
          the_result = CONVERT('CEY', '+-*', the_string)
       END ELSE
          the_result = CONVERT(the_string, 'CEY', '+-*')
       END
       *
       CRT jbc_emu, the_result                ;* e.g. prime AB+++D-F+D*Z
