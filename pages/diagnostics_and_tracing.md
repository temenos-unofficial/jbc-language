# Diagnostics and tracing

Being set to 1 redirects stderr to stdout (useful to catch errors to COMO output):

<pre>
    JBC_STDERR</pre>

Being set to 1 stipulates creation of a core dump when the session crashes:

<pre>
    JBC_CORE_DUMP</pre>

jBASE tracing options:

<pre>
    JDIAG</pre>

E.g.:

<pre>
    set JDIAG=trace=JVM,CALLJ
    set JDIAG=TRACE=INDEX</pre>
