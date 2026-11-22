# BREAK ON/OFF

Enables or disables the BREAK key. In UNIX terms, the BREAK key is known more commonly as the interrupt
sequence intr defined by the stty command.

## COMMAND SYNTAX

    BREAK ON / BREAK OFF

## EXAMPLE

       BREAK OFF
       CRT "Next 5 seconds Ctrl-C makes no action"
       MSLEEP(5000)
       BREAK ON
       CRT "And next 5 seconds Ctrl-C invokes debugger"
       MSLEEP(5000)

Output (user is to try to press Ctrl-C at both prompts):

<pre>
    Next 5 seconds Ctrl-C makes no action
    And next 5 seconds Ctrl-C invokes debugger
    Interrupt signal
    Source changed to .\test2.b
    0009    MSLEEP(5000)
    jBASE debugger-></pre>
