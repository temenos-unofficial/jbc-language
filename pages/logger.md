# Logger

The logger function allows you to log your message in a file or display to
screen.

## COMMAND SYNTAX

    Logger(Category, Severity, Message)

## SYNTAX ELEMENTS

**Category** is any user defined category. Any meaningful name can be
provided.

**Severity**: You can use predefined severity level for your logging
information.

TAFC_LOG_INFO

TAFC_LOG_WARNING

TAFC_LOG_ERROR

TAFC_LOG_FATAL

**Message** is any user defined meaningful message for logging.

## NOTES

You can control logging information from tafc.ini, please refer to the user
guide for more details.

## EXAMPLE

    INCLUDE JBC.h
    Logger('ACC', TAFC_LOG_INFO, 'Message for ACC category at INFO level')
    Logger('ACC', TAFC_LOG_WARNING, 'Message for ACC category at WARNING level')
    Logger('ACC', TAFC_LOG_ERROR, 'Message for ACC category at ERROR level')
