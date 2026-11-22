# @ (SCREENCODE)

Use @(SCREENCODE) to output control sequences according to the
capabilities of the terminal

## COMMAND SYNTAX

    @ (ScreenCode)

## SYNTAX ELEMENTS

Control sequences for special capabilities of the terminal are achieved
by passing a negative number as its argument. ScreenCode is therefore
any expression that evaluates to a negative argument.

## NOTES

The design of TAFC allows you to import code from many older systems.
As these systems have traditionally not co-ordinated the development of
this function they expect different functionality in many instances. In
the following table, you should note that different settings of the
JBCEMULATE environment variable would elicit different functionality
from this function.

| Emulation | Code  | Function                                       |
|-----------|-------|------------------------------------------------|
| all       |  -1   | clear the screen and home the cursor           |
| all       |  -2   | Home the cursor                                |
| all       |  -3   | clear screen from the cursor to the end of the |
|           |       | screen                                         |
| all       |  -4   | clear screen from cursor to the end of the     |
|           |       | current screen line                            |
| ros       |  -5   | turn on character blinking                     |
| ros       |  -6   | turn off character blinking                    |
| ros       |  -7   | turn on protected field mode                   |
| ros       |  -8   | turn off protected field mode                  |
| all       |  -9   | move the cursor one character to the left      |
| all       | -10   | move the cursor one row up the screen          |
| ros       | -11   | turn on the cursor (visible)                   |
| ros       | -11   | enable protect mode                            |
| ros       | -12   | turn off the cursor (invisible)                |
| ros       | -12   | disable protect mode                           |
| ros       | -13   | status line on                                 |
| ros       | -13   | turn on reverse video mode                     |
| ros       | -14   | status line off                                |
| ros       | -14   | turn off reverse video mode                    |
| ros       | -15   | move cursor forward one character              |
| ros       | -15   | turn on underline mode                         |
| ros       | -16   | move cursor one row down the screen            |
| ros       | -16   | turn off underline mode                        |
| all       | -17   | turn on the slave (printer) port               |
| all       | -18   | turn off the slave (printer) port              |
| ros       | -19   | dump the screen to the slave port              |
| ros       | -19   | move the cursor right one character            |
| ros       | -20   | move the cursor down one character             |
| ros       | -311  | turn on the cursor (visible)                   |
| ros       | -312  | turn off the cursor (invisible)                |
| ros       | -313  | turn on the status line                        |
| ros       | -314  | turn off the status line                       |

If a colour terminal is in use, -33 to -64 will control colours.

The codes from -128 to -191 control screen attributes. Where Bit 0 is
least significant, you may calculate the desired code by setting Bit
7 and Bits 0-5:

| Bit Values | Description                   |
|------------|-------------------------------|
| Bit 0      | dimmed mode when set to 1     |
| Bit 1      | flashing mode when set to 1   |
| Bit 2      | reverse mode when set to 1    |
| Bit 3      | blanked mode when set to 1    |
| Bit 4      | underline mode when set to 1  |
| Bit 5      | bold mode when set to 1       |
| Bit 7      | always set to 1               |

Thus, reverse and flashing mode is -134.

To turn off all effects use -128.

## EXAMPLE

       CRT @(-1):@(30):@(52):'jBASE Heading':@(-128):
       CRT @(5,5):@(-4):'Prompt: ': ; INPUT Answer
