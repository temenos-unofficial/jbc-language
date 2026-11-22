# CacheGet

The CacheExists function will return a value of an item from the
specified bucket of the cache. If an item is not in existance it
returns an empty string.

## COMMAND SYNTAX

    CacheGet(bucket,  item)

## EXAMPLE

    INCLUDE JBC.h
    CRT '[': CacheGet('bucket1', 'item1'):']'
    CachePut('bucket1', 'item1', 'value1')
    CRT '[': CacheGet('bucket1', 'item1'):']'

The output is:

<pre>
    []
    [value1]</pre>

## NOTES

This function increments CACHE_GETS statistics counter of the bucket.
If an item exists in the bucket the function increments CACHE_HITS
counter of this bucket.
