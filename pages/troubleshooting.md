# TROUBLESHOOTING

When attempting to compile a program with Embedded SQL and you get an
error along the lines of...

<pre>
    Command failed: nsqlprep PartEntry.sqc
    SQL Pre Processor error -1</pre>

...this is an indication that either you have not loaded the Embedded
SQL Kit and do not have the 'nsqlprep' command, or the 'nsqlprep'
command does exist but it is not visible to the PATH environment
variable.
