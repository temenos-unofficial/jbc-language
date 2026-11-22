# CacheClearAll

The CacheClearAll function will clean all buckets in the cache.

## COMMAND SYNTAX

    CacheClearAll()

## EXAMPLE

    INCLUDE JBC.h
    CachePut('ACCOUNT', 'username', 'customer1')
    CRT '[': CacheGet('ACCOUNT', 'username'):']'
    CacheClearAll()
    CRT '[': CacheGet('ACCOUNT', 'username'):']'

The output is:

<pre>
    [customer1]
    []</pre>

## NOTES

The CacheClearAll() function also resets the statistics of all buckets.
