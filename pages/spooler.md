# SPOOLER

SPOOLER function returns information from the jBASE spooler.

## COMMAND SYNTAX

    SPOOLER(n{, Port | User})

## SYNTAX ELEMENTS

Are as follows:

|n  |     Description                |
|---|--------------------------------|
|1  |  returns formqueue information |
|2  |  returns job information       |
|3  |  forms queue assignment        |
|4  |  returns status information    |

**Port** limits the information returned to the specified port.

**User** limits the information returned to the specified user.

## NOTES

SPOOLER(1) returns information about formqueues. The information is
returned in a dynamic array, which contains an attribute for each
formqueue. Each formqueue is structured as follows:

|Multivalue |  Description                      |
|-----------|-----------------------------------|
|1          |  Formqueue name                   |
|2          |  Form type                        |
|3          |  Device                           |
|4          |  Device type                      |
|5          |  Status                           |
|6          |  Number of jobs on the formqueue  |
|7          |  Page skip                        |

SPOOLER(2) returns information about print jobs. The information is
returned in a dynamic array, which contains an attribute for each
print job.

|Multivalue |  Description                      |
|-----------|-----------------------------------|
|1          |  Formqueue name                   |
|2          |  Print job number                 |
|3          |  Effective user id                |
|4          |  Port number job generated on     |
|5          |  Creation date in internal format |
|6          |  Creation time in internal format |
|7          |  Job Status                       |
|8          |  Options                          |
|9          |  Print job size (pages)           |
|10         |  Copies                           |
|11         |  Reserved                         |
|12         |  Reserved                         |
|13         |  Reserved                         |
|14         |  Effective user id                |
|15         |  Real user id                     |
|16         |  Application id as set by         |
|           |  @APPLICATION.ID                  |
|17         |  JBASICLOGNAME id                 |

SPOOLER(3) returns information about current formqueue assignments.
The information is returned in a dynamic array, which contains an
attribute for each assignment. Each attribute is structured as
follows:

|Multivalue |  Description                      |
|-----------|-----------------------------------|
|1          |  Report (channel) number          |
|2          |  Formqueue name                   |
|3          |  Options                          |
|4          |  Copies                           |

SPOOLER(4) returns information about current print jobs. The information
is returned in a dynamic array, which contains an attribute for each job
being generated. Each attribute is structured as follows:

|Multivalue |  Description                      |
|-----------|-----------------------------------|
|1          |  Report (channel) number          |
|2          |  Print job number                 |
|3          |  Print job size (pages)           |
|4          |  Creation date in internal format |
|5          |  Creation date in internal format |
|6          |  Job Status                       |
|7          |  Effective User id                |
|8          |  Real user id                     |
|9          |  JBASICLOGNAME id                 |
|10         |  Banner test from SETPTR BANNER   |
|           |  text command                     |

The values for Job Status are:

|Status|  Description |
|------|--------------|
|1     |  Queued      |
|2     |  Printing    |
|3     |  Finished    |
|4     |  Open        |
|5     |  Hold        |
|6     |  Edited      |
