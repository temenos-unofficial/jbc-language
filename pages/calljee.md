# CALLJEE

The CALLJEE function will connect to the JRemote Inbound JCA (TOCF/EE)
if not already connected, send the request, and receive the response.
The first invocation of CALLJEE will attempt to open a connection to the
application server. The following environment variables are used during
the open connection phase of the first call:

<pre>
    SET JREMOTE_INBOUND_HOST=127.0.0.1
    SET JREMOTE_INBOUND_PORT=55006</pre>

Subsequent invocations of CALLJEE will use a connection previously opened
by CALLJEE.

## EXAMPLE

    INCLUDE JBC.h
    ACTIVATION = "PRICE"
    ADDINFO = "PART.NUMBER=MC3815-3"
    ERR.CODE = CALLJEE(ACTIVATION, ADDINFO)
    RESULT = ADDINFO

Error codes:

| Code | Description                                             |
|------|---------------------------------------------------------|
| 0    | Action completed successfully                           |
| 1    | Communication error, this connection is no longer valid |
| 2    | Transaction error, the transaction is no longer valid   |
| 101  | Connect error, host not valid                           |
| 102  | Connect error, port not valid                           |
