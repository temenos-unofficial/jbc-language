# JBASETHREADStatus

JBASETHREADStatus command shows the status of all running threads.

## COMMAND SYNTAX

    JBASETHREADStatus(ThreadList)

## SYNTAX ELEMENTS

**ThreadList** is a list of the threads active in this process,
with one attribute per thread.

The layout of the multi-values in each attribute is as follows:

| Value   |    Description                                |
|---------|-----------------------------------------------|
|< n,1 >  |  port number                                  |
|< n,2 >  |  thread handle returned from JBASETHREADCreate|
