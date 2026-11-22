# Introduction to jBASE/TAFC data files

The most widely used formats for data files nowadays are "J4" and "JR".
The former has size limitation (up to 2Gb if OS-level limits allow that)
and needs resizing on regular basis though when it's properly sized it's
faster. "JR" - "resilient" - doesn't have size limitation and
doesn't need resizing.

The following examples serve as a brief introduction to jBASE data storage.
They can be executed in jshell prompt or (except JED - it makes no sense)
in a jBC program or subroutine (using EXECUTE/PERFORM).
