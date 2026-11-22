# CachePut

The CacheExists function will put an item to the specified bucket of
the cache.

## COMMAND SYNTAX

    CachePut(bucket, item, value)

## EXAMPLE

    INCLUDE JBC.h
    CachePut('bucket1', 'item1', 'value1')
    CRT '[': CacheGet('bucket1', 'item1'):']'

The output is:

<pre>
    [value1]</pre>

## NOTES

This function increments CACHE_PUTS statistics counter of the bucket.
