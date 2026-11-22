# CacheClear

The CacheClear function will delete all items in a bucket of the cache.

## COMMAND SYNTAX

    CacheClear(bucketname)

## EXAMPLE

    INCLUDE JBC.h
    CachePut('ACCOUNT', 'username', 'customer1')
    CRT '[': CacheGet('ACCOUNT', 'username'):']'
    CacheClear('ACCOUNT')
    CRT '[': CacheGet('ACCOUNT', 'username'):']'

The output is:

<pre>
    [customer1]
    []</pre>

## NOTES

The CacheClear() function also resets the statistics of a bucket.
