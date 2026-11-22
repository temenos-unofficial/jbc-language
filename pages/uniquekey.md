# UNIQUEKEY

UNIQUEKEY returns a unique 36-byte character key.

## COMMAND SYNTAX

    UNIQUEKEY()

## SYNTAX ELEMENTS

The UNIQUEKEY() function will generate a UUID (Universally Unique IDentifier),
also known as GUID (Globally Unique IDentifier).

## EXAMPLE

       FOR V.I = 1 TO 5
          CRT FMT( DOWNCASE( FMT( UNIQUEKEY(), 'MX')),   \
                'L(########-####-####-############)')
       NEXT V.I

Sample output:

<pre>
    41505741-4141-4445-7935727a6a35
    41505741-4141-4445-7935727a6a36
    41505741-4141-4445-7935727a6a37
    41505741-4141-4445-7935727a6a38
    41505741-4141-4445-7935727a6a39</pre>
